From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
Date: Tue, 8 Oct 2019 07:38:14 -0500
Message-ID: <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
References: <20191004151414.8458-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004151414.8458-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maciej Falkowski <m.falkowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 4, 2019 at 10:14 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The clkoutN names of clocks must be unique because they represent
> unique inputs of clock multiplexer.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> index 73b56fc5bf58..d8e03716f5d2 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> @@ -53,8 +53,10 @@ properties:
>        List of clock names for particular CLKOUT mux inputs
>      minItems: 1
>      maxItems: 32
> -    items:
> -      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> +    allOf:
> +      - items:
> +          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> +      - uniqueItems: true

You shouldn't need the 'allOf', just add uniqueItems at the same level as items.

Rob
