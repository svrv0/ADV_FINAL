<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Review</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif; background: radial-gradient(ellipse at 10% 0%, rgba(255,192,203,0.28), transparent 55%), radial-gradient(ellipse at 90% 100%, rgba(255,182,164,0.22), transparent 50%), #fdf6f8; color: #3d2a2e; min-height: 100vh; }
        .page-shell { min-height: 100vh; padding: 32px 16px; }
        .page-container { width: min(1120px, 100%); margin: 0 auto; }
        .detail-layout { width: min(720px, 100%); margin: 0 auto; }
        .stack { display: grid; gap: 20px; }
        .detail-card, .panel { background: rgba(255, 252, 253, 0.92); border: 1px solid rgba(225, 170, 185, 0.3); border-radius: 24px; box-shadow: 0 2px 0 rgba(255,255,255,0.9) inset, 0 12px 40px rgba(180,80,110,0.07); backdrop-filter: blur(12px); padding: 28px; }
        .pill { display: inline-flex; align-items: center; gap: 8px; padding: 8px 14px; border-radius: 999px; background: rgba(232, 115, 142, 0.12); color: #b84d68; font-weight: 700; width: fit-content; }
        .detail-title { font-size: clamp(1.25rem, 2.2vw, 1.75rem); margin: 0 0 10px; color: #2e1a20; letter-spacing: -0.02em; }
        .muted { margin: 0; color: #b8738a; }
        .success-message { padding: 10px 12px; border-radius: 12px; margin: 0; font-weight: 600; background: rgba(16, 185, 129, 0.12); color: #047857; }
        .error-message { padding: 10px 12px; border-radius: 12px; margin: 0; font-weight: 600; background: rgba(239, 68, 68, 0.12); color: #b91c1c; }
        .form-stack { display: grid; gap: 12px; }
        .panel-header { margin-bottom: 18px; }
        .section-title { font-size: clamp(1.25rem, 2.2vw, 1.75rem); margin: 0 0 10px; color: #2e1a20; letter-spacing: -0.02em; border-left: 4px solid #f9a8d4; padding-left: 12px; }
        input, select, textarea { width: 100%; padding: 14px 16px; border: 1.5px solid rgba(210, 140, 160, 0.35); border-radius: 14px; background: rgba(255, 248, 250, 0.95); color: #2e1a20; font: inherit; transition: border-color 160ms ease, box-shadow 160ms ease; }
        input::placeholder, textarea::placeholder { color: #cbbae3; opacity: 1; font-size: 0.95em; font-weight: 400; }
        input:focus, select:focus, textarea:focus { outline: none; border-color: #d4728e; box-shadow: 0 0 0 4px rgba(212, 114, 142, 0.14); }
        textarea { resize: vertical; min-height: 96px; }
        .form-label { display: block; color: #2e1a20; font-size: 0.95rem; font-weight: 600; margin-bottom: 8px; }
        button { display: inline-flex; align-items: center; justify-content: center; gap: 8px; min-height: 46px; padding: 0 18px; border: 0; border-radius: 999px; background: linear-gradient(135deg, #e8738e, #f4a1b0); color: #ffffff; font-weight: 600; cursor: pointer; width: 100%; box-shadow: 0 4px 18px rgba(220,100,130,0.28); transition: transform 160ms ease, box-shadow 160ms ease, filter 160ms ease; }
        button:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(220,100,130,0.36); filter: brightness(1.04); }
        .toolbar-group { display: flex; flex-wrap: wrap; gap: 12px; align-items: center; width: 100%; }
        .button-link { display: inline-flex; align-items: center; justify-content: center; gap: 8px; min-height: 46px; padding: 0 18px; border: 0; border-radius: 999px; background: linear-gradient(135deg, #e8738e, #f4a1b0); color: #ffffff; font-weight: 600; cursor: pointer; text-decoration: none; width: 100%; box-shadow: 0 4px 18px rgba(220,100,130,0.28); transition: transform 160ms ease, box-shadow 160ms ease, filter 160ms ease; }
        .button-link:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(220,100,130,0.36); filter: brightness(1.04); text-decoration: none; }
        .button-link.ghost { background: rgba(232, 115, 142, 0.09); color: #c2607a; box-shadow: none; border: 1.5px solid rgba(210, 140, 160, 0.3); }
        .button-link.ghost:hover { background: rgba(232, 115, 142, 0.18); color: #a84865; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(220,100,130,0.1); }
        @media (max-width: 640px) { .page-shell { padding: 20px 12px; } .detail-card, .panel { padding: 20px; border-radius: 20px; } button, .button-link { width: 100%; } }
    </style>
</head>
<body>

<main class="page-shell">
    <div class="page-container detail-layout">
        <section class="detail-card stack">
            <div>
                <p class="pill">Submit review</p>
                <h1 class="detail-title"><c:out value="${product.name}"/></h1>
                <p class="muted">Share your rating and feedback for this product.</p>
            </div>

            <c:if test="${param.review eq 'added'}">
                <p class="success-message">Your review was added successfully.</p>
            </c:if>
            <c:if test="${param.review eq 'exists'}">
                <p class="error-message">You already reviewed this product.</p>
            </c:if>

            <section class="panel stack">
                <div class="panel-header">
                    <h2 class="section-title">Share your feedback</h2>
                    <p class="muted">Help other users by rating and reviewing this product.</p>
                </div>
                <form method="post" action="${pageContext.request.contextPath}/reviews/add" class="form-stack">
                    <input type="hidden" name="productId" value="${product.id}" />
                    <div>
                        <label for="rating" class="form-label">Rating *</label>
                        <select id="rating" name="rating" required>
                            <option value="">Choose rating</option>
                            <option value="5">★★★★★ 5 - Excellent</option>
                            <option value="4">★★★★☆ 4 - Good</option>
                            <option value="3">★★★☆☆ 3 - Average</option>
                            <option value="2">★★☆☆☆ 2 - Poor</option>
                            <option value="1">★☆☆☆☆ 1 - Very bad</option>
                        </select>
                    </div>
                    <div>
                        <label for="title" class="form-label">Title (optional)</label>
                        <input type="text" id="title" name="title" placeholder="Review title" />
                    </div>
                    <div>
                        <label for="comment" class="form-label">Comment (optional)</label>
                        <textarea id="comment" name="comment" rows="4" placeholder="Your comment"></textarea>
                    </div>
                    <button type="submit">Submit review</button>
                </form>
            </section>

            <div class="toolbar-group">
                <a class="button-link ghost" href="${pageContext.request.contextPath}/product?id=${product.id}">Back to product</a>
                <a class="button-link" href="${pageContext.request.contextPath}/reviews/view?productId=${product.id}">View reviews</a>
            </div>
        </section>
    </div>
</main>

</body>
</html>