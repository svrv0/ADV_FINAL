<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif; background: radial-gradient(ellipse at 10% 0%, rgba(255,192,203,0.28), transparent 55%), radial-gradient(ellipse at 90% 100%, rgba(255,182,164,0.22), transparent 50%), #fdf6f8; color: #3d2a2e; min-height: 100vh; }
        .page-shell { min-height: 100vh; padding: 32px 16px; }
        .page-container { width: min(1120px, 100%); margin: 0 auto; }
        .detail-layout { width: min(720px, 100%); margin: 0 auto; }
        .stack { display: grid; gap: 20px; }
        .detail-card, .panel { background: rgba(255, 252, 253, 0.92); border: 1px solid rgba(225, 170, 185, 0.3); border-radius: 24px; box-shadow: 0 2px 0 rgba(255,255,255,0.9) inset, 0 12px 40px rgba(180,80,110,0.07); backdrop-filter: blur(12px); padding: 28px; }
        .pill { display: inline-flex; align-items: center; gap: 8px; padding: 6px 14px; border-radius: 999px; background: rgba(232, 115, 142, 0.12); color: #b84d68; font-weight: 700; width: fit-content; font-size: 0.88rem; }
        .detail-title { font-size: clamp(1.25rem, 2.2vw, 1.75rem); margin: 0 0 10px; color: #2e1a20; letter-spacing: -0.02em; }
        .muted { margin: 0; color: #9e7280; }
        .section-title { font-size: clamp(1.25rem, 2.2vw, 1.75rem); margin: 0 0 10px; color: #2e1a20; letter-spacing: -0.02em; }
        .panel-header { margin-bottom: 18px; }
        .form-stack { display: grid; gap: 12px; }
        .form-label { display: block; color: #2e1a20; font-size: 0.95rem; font-weight: 600; margin-bottom: 8px; }
        input, select, textarea { width: 100%; padding: 13px 18px; border: 1.5px solid rgba(210, 140, 160, 0.35); border-radius: 14px; background: rgba(255, 248, 250, 0.95); color: #2e1a20; font: inherit; transition: border-color 160ms ease, box-shadow 160ms ease; }
        input:focus, select:focus, textarea:focus { outline: none; border-color: #d4728e; box-shadow: 0 0 0 4px rgba(212, 114, 142, 0.14); }
        button, .button-link { display: inline-flex; align-items: center; justify-content: center; gap: 8px; min-height: 46px; padding: 0 18px; border: 0; border-radius: 999px; background: linear-gradient(135deg, #e8738e, #f4a1b0); color: #ffffff; font-weight: 600; cursor: pointer; text-decoration: none; box-shadow: 0 4px 18px rgba(220,100,130,0.28); transition: transform 160ms ease, box-shadow 160ms ease, filter 160ms ease; }
        button:hover, .button-link:hover { text-decoration: none; transform: translateY(-2px); box-shadow: 0 8px 28px rgba(220,100,130,0.36); filter: brightness(1.04); }
        .button-link.secondary { background: linear-gradient(135deg, #f9b8c6, #fdd5de); color: #8b3a52; box-shadow: 0 4px 18px rgba(220,100,130,0.14); }
        .button-link.ghost { background: rgba(232, 115, 142, 0.09); color: #c2607a; box-shadow: none; border: 1.5px solid rgba(210, 140, 160, 0.3); }
        .toolbar-group { display: flex; flex-wrap: wrap; gap: 12px; align-items: center; width: 100%; }
        a { color: #c2607a; text-decoration: none; }
        a:hover { text-decoration: underline; color: #a84865; }
        @media (max-width: 640px) { .page-shell { padding: 20px 12px; } .detail-card, .panel { padding: 20px; border-radius: 20px; } button, .button-link { width: 100%; } }
    </style>
</head>
<body>

<main class="page-shell">
    <div class="page-container detail-layout">
        <section class="detail-card stack">
            <div>
                <p class="pill">Edit product</p>
                <h1 class="detail-title">${product.name}</h1>
                <p class="muted">Update the product name and price, then save your changes.</p>
            </div>

            <section class="panel">
                <div class="panel-header">
                    <h2 class="section-title">Product information</h2>
                    <p class="muted">Change the name and price for this product.</p>
                </div>
                <c:if test="${not empty error}">
                    <div style="padding: 12px 16px; border-radius: 10px; background: rgba(232, 115, 142, 0.12); border: 1px solid rgba(210, 140, 160, 0.35); color: #a33050; font-weight: 600; margin-bottom: 16px;">
                            ${error}
                    </div>
                </c:if>
                <form method="post" action="${pageContext.request.contextPath}/products/update" class="form-stack">
                    <input type="hidden" name="id" value="${product.id}" />
                    <div>
                        <label class="form-label">Product name</label>
                        <input type="text" name="name" value="${product.name}" required />
                    </div>
                    <div>
                        <label class="form-label">Price</label>
                        <input type="number" step="0.01" name="price" value="${product.price}" required />
                    </div>
                    <button type="submit">Save changes</button>
                </form>
            </section>

            <div class="toolbar-group">
                <a class="button-link ghost" href="${pageContext.request.contextPath}/product?id=${product.id}">View product</a>
                <a class="button-link ghost" href="${pageContext.request.contextPath}/ProductsMain">Back to products</a>
                <form method="post" action="${pageContext.request.contextPath}/products/delete">
                    <input type="hidden" name="id" value="${product.id}" />
                    <button type="submit" class="button-link secondary">Delete product</button>
                </form>
            </div>
        </section>
    </div>
</main>

</body>
</html>
