<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reviews</title>
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
        a { color: #c2607a; text-decoration: none; }
        a:hover { text-decoration: underline; color: #a84865; }
        .panel-header { margin-bottom: 18px; }
        .section-title { font-size: clamp(1.25rem, 2.2vw, 1.75rem); margin: 0 0 10px; color: #2e1a20; letter-spacing: -0.02em; border-left: 4px solid #f9a8d4; padding-left: 12px; }
        .review-grid { display: grid; gap: 12px; }
        .review-card { padding: 14px; border-radius: 14px; border: 1px solid rgba(225, 170, 185, 0.3); background: rgba(255, 248, 250, 0.85); display: grid; gap: 10px; }
        .review-header { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
        .review-rating { color: #f59e0b; font-size: 0.9rem; font-weight: 600; margin-left: 6px; }
        .review-title { margin: 0; color: #2e1a20; font-size: 1rem; font-weight: 700; }
        .review-comment { margin: 0; color: #624b7c; font-size: 0.95rem; line-height: 1.5; }
        .toolbar-group { display: flex; flex-wrap: wrap; gap: 12px; align-items: center; width: 100%; }
        .button-link { display: inline-flex; align-items: center; justify-content: center; gap: 8px; min-height: 46px; padding: 0 18px; border: 0; border-radius: 999px; background: linear-gradient(135deg, #e8738e, #f4a1b0); color: #ffffff; font-weight: 600; cursor: pointer; text-decoration: none; width: 100%; box-shadow: 0 4px 18px rgba(220,100,130,0.28); transition: transform 160ms ease, box-shadow 160ms ease, filter 160ms ease; }
        .button-link:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(220,100,130,0.36); filter: brightness(1.04); text-decoration: none; }
        .button-link.ghost { background: rgba(232, 115, 142, 0.09); color: #c2607a; box-shadow: none; border: 1.5px solid rgba(210, 140, 160, 0.3); }
        .button-link.ghost:hover { background: rgba(232, 115, 142, 0.18); color: #a84865; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(220,100,130,0.1); }
        .pill:has(span) { background: rgba(232, 115, 142, 0.12); color: #b84d68; } /* للتقييم الذي يظهر كـ pill */
        @media (max-width: 640px) { .page-shell { padding: 20px 12px; } .detail-card, .panel { padding: 20px; border-radius: 20px; } .button-link { width: 100%; } }
    </style>
</head>
<body>

<main class="page-shell">
    <div class="page-container detail-layout">
        <section class="detail-card stack">
            <div>
                <p class="pill">Product reviews</p>
                <h1 class="detail-title"><c:out value="${product.name}"/></h1>
                <p class="muted">Latest feedback from users.</p>
            </div>

            <section class="panel stack">
                <div class="panel-header">
                    <h2 class="section-title">Customer reviews</h2>
                    <p class="muted">See what other users think about this product.</p>
                </div>
                <c:choose>
                    <c:when test="${empty reviews}">
                        <p class="muted">No reviews yet for this product. <a href="${pageContext.request.contextPath}/reviews/new?productId=${product.id}">Be the first to review</a>.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="review-grid">
                            <c:forEach var="review" items="${reviews}">
                                <article class="review-card">
                                    <div class="review-header">
                                        <div>
                                            <strong><c:out value="${review.username}"/></strong>
                                            <span class="review-rating">★<c:out value="${review.rating}"/>.0</span>
                                        </div>
                                        <span class="pill"><c:out value="${review.rating}"/>/5</span>
                                    </div>
                                    <c:if test="${not empty review.title}">
                                        <h4 class="review-title"><c:out value="${review.title}"/></h4>
                                    </c:if>
                                    <c:if test="${not empty review.comment}">
                                        <p class="review-comment"><c:out value="${review.comment}"/></p>
                                    </c:if>
                                </article>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <div class="toolbar-group">
                <a class="button-link ghost" href="${pageContext.request.contextPath}/product?id=${product.id}">Back to product</a>
                <a class="button-link" href="${pageContext.request.contextPath}/reviews/new?productId=${product.id}">Submit review</a>
            </div>
        </section>
    </div>
</main>

</body>
</html>