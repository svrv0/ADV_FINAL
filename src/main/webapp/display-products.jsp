<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif; background: radial-gradient(ellipse at 10% 0%, rgba(255,192,203,0.28), transparent 55%), radial-gradient(ellipse at 90% 100%, rgba(255,182,164,0.22), transparent 50%), #fdf6f8; color: #3d2a2e; min-height: 100vh; }
        .page-shell { min-height: 100vh; padding: 32px 16px; }
        .page-container { width: min(1120px, 100%); margin: 0 auto; }
        .stack { display: grid; gap: 20px; }
        .hero-card, .panel, .product-card, .detail-card { background: rgba(255, 252, 253, 0.92); border: 1px solid rgba(225, 170, 185, 0.3); border-radius: 24px; box-shadow: 0 2px 0 rgba(255,255,255,0.9) inset, 0 12px 40px rgba(180,80,110,0.07); backdrop-filter: blur(12px); }
        .hero-card, .panel, .detail-card { padding: 28px; }
        .product-card { padding: 18px; display: grid; gap: 12px; }
        .hero-title, .section-title, .detail-title { margin: 0 0 10px; color: #2e1a20; letter-spacing: -0.02em; }
        .hero-title { font-size: clamp(2rem, 4vw, 3.25rem); background: linear-gradient(135deg, #6d28d9, #db2777); background-clip: text; -webkit-background-clip: text; color: transparent; display: inline-block; }
        .section-title, .detail-title { font-size: clamp(1.25rem, 2.2vw, 1.75rem); border-left: 4px solid #f9a8d4; padding-left: 12px; }
        .muted { margin: 0; color: #b8738a; }
        .pill { display: inline-flex; align-items: center; gap: 8px; padding: 8px 14px; border-radius: 999px; background: rgba(232, 115, 142, 0.12); color: #b84d68; font-weight: 700; width: fit-content; }
        .admin-badge { display: inline-flex; align-items: center; gap: 8px; margin-left: 10px; padding: 6px 12px; border-radius: 999px; background: rgba(16, 185, 129, 0.12); color: #047857; font-size: 0.9rem; font-weight: 800; vertical-align: middle; }
        .toolbar { display: flex; flex-wrap: wrap; gap: 12px; align-items: center; justify-content: space-between; }
        .toolbar-group { display: flex; flex-wrap: wrap; gap: 12px; align-items: center; }
        a { color: #c2607a; text-decoration: none; }
        a:hover { text-decoration: underline; color: #a84865; }
        .product-grid { display: grid; gap: 18px; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); }
        .product-meta { display: grid; gap: 6px; color: #624b7c; }
        .product-id { display: inline-flex; align-items: center; justify-content: center; width: fit-content; padding: 6px 10px; border-radius: 999px; background: rgba(232, 115, 142, 0.1); color: #b84d68; font-size: 0.9rem; font-weight: 700; }
        .product-info-link { display: block; padding: 8px; margin: -8px; border-radius: 12px; color: inherit; text-decoration: none; transition: background-color 160ms ease, box-shadow 160ms ease; cursor: pointer; }
        .product-info-link:hover { background-color: rgba(232, 115, 142, 0.1); text-decoration: none; box-shadow: inset 0 0 0 1px rgba(232, 115, 142, 0.3); }
        button, .button-link { display: inline-flex; align-items: center; justify-content: center; gap: 8px; min-height: 46px; padding: 0 18px; border: 0; border-radius: 999px; background: linear-gradient(135deg, #e8738e, #f4a1b0); color: #ffffff; font-weight: 600; cursor: pointer; text-decoration: none; box-shadow: 0 4px 18px rgba(220,100,130,0.28); transition: transform 160ms ease, box-shadow 160ms ease, filter 160ms ease; }
        button:hover, .button-link:hover { text-decoration: none; transform: translateY(-2px); box-shadow: 0 8px 28px rgba(220,100,130,0.36); filter: brightness(1.04); }
        .button-link.secondary { background: linear-gradient(135deg, #f9b8c6, #fdd5de); color: #8b3a52; box-shadow: 0 4px 18px rgba(220,100,130,0.14); }
        .button-link.ghost { background: rgba(232, 115, 142, 0.09); color: #c2607a; box-shadow: none; border: 1.5px solid rgba(210, 140, 160, 0.3); }
        .admin-panel { display: grid; gap: 16px; }
        .form-stack { display: grid; gap: 12px; }
        .field-row { display: grid; gap: 12px; }
        .split-grid { display: grid; gap: 20px; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); }
        input, select, textarea { width: 100%; padding: 14px 16px; border: 1.5px solid rgba(210, 140, 160, 0.35); border-radius: 14px; background: rgba(255, 248, 250, 0.95); color: #2e1a20; font: inherit; transition: border-color 160ms ease, box-shadow 160ms ease; }
        input::placeholder, textarea::placeholder { color: #cbbae3; opacity: 1; font-size: 0.95em; font-weight: 400; }
        input:focus, select:focus, textarea:focus { outline: none; border-color: #d4728e; box-shadow: 0 0 0 4px rgba(212, 114, 142, 0.14); }
        textarea { resize: vertical; min-height: 96px; }
        hr { border: 0; height: 1px; margin: 24px 0; background: linear-gradient(90deg, transparent, rgba(232, 115, 142, 0.5), transparent); border-radius: 4px; }
        @media (max-width: 640px) { .page-shell { padding: 20px 12px; } .hero-card, .panel, .product-card, .detail-card { padding: 20px; border-radius: 20px; } button, .button-link { width: 100%; } .toolbar, .toolbar-group { width: 100%; } }
    </style>
</head>
<body>

<main class="page-shell">
    <div class="page-container stack">
        <section class="hero-card stack">
            <div class="toolbar">
                <div>
                    <p class="pill">Product center</p>
                    <h1 class="hero-title">Product list</h1>
                    <p class="muted">Logged in as <strong>${user}</strong><c:if test="${isAdmin}"><span class="admin-badge">Admin</span></c:if></p>
                </div>
                <div class="toolbar-group">
                    <a class="button-link ghost" href="${pageContext.request.contextPath}/logout">Sign out</a>
                    <form method="post" action="${pageContext.request.contextPath}/delete-account">
                        <button type="submit" class="button-link secondary">Delete account</button>
                    </form>
                </div>
            </div>
        </section>



        <hr />
        <c:if test="${isAdmin}">
                <section class="panel admin-panel">
            <div>
                <h2 class="section-title">Manage products</h2>
                <p class="muted">Add, delete, or open a product to edit its details.</p>
            </div>
            <c:if test="${not empty error and fn:trim(error) ne ''}">
              <div style="padding: 12px 16px; border-radius: 10px; background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); color: #dc2626; font-weight: 600; margin-bottom: 16px;">
                ${error}
              </div>
            </c:if>
            <form method="post" action="${pageContext.request.contextPath}/products/add" class="form-stack">
                <div class="field-row split-grid">
                    <input type="text" name="name" placeholder="Enter product name" required />
                    <input type="number" step="0.01" name="price" placeholder="Enter price" required />
                </div>
                <button type="submit">Add product</button>
            </form>
        </section>
        </c:if>
        <section class="panel stack">
            <div>
                <h2 class="section-title">All Products</h2>
                <p class="muted">All products at database listed here.</p>
            </div>
        </section>

        <section class="product-grid">
            <c:forEach var="item" items="${data}">
                <article class="product-card">
                    <a href="${pageContext.request.contextPath}/product?id=${item.id}" class="product-info-link">
                        <div class="product-id">#${item.id}</div>
                        <div class="product-meta">
                            <div><strong>${item.name}</strong></div>
                            <div>$${item.price}</div>
                        </div>
                    </a>
                    <div class="toolbar-group">
                        <c:if test="${isAdmin}">
                        <a class="button-link" href="${pageContext.request.contextPath}/product/edit?id=${item.id}">Edit</a>
                            <form method="post" action="${pageContext.request.contextPath}/products/delete">
                                <input type="hidden" name="id" value="${item.id}" />
                                <button type="submit" class="button-link secondary">Remove</button>
                            </form>
                        </c:if>
                    </div>
                    <div class="toolbar-group">
                        <a class="button-link" href="${pageContext.request.contextPath}/reviews/new?productId=${item.id}">Submit review</a>
                        <a class="button-link ghost" href="${pageContext.request.contextPath}/reviews/view?productId=${item.id}">View reviews</a>
                    </div>
                </article>
            </c:forEach>
        </section>
        <!-- <hr /> -->

    </div>
</main>
</body>
</html>
