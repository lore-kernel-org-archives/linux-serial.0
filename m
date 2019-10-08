From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
Date: Tue, 8 Oct 2019 09:05:32 -0500
Message-ID: <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
References: <20191004151414.8458-1-krzk@kernel.org> <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
 <20191008125038.GA2550@pi3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191008125038.GA2550@pi3>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maciej Falkowski <m.falkowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 8, 2019 at 7:50 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Oct 08, 2019 at 07:38:14AM -0500, Rob Herring wrote:
> > On Fri, Oct 4, 2019 at 10:14 AM Krzysztof Kozlowski <krzk@kernel.org> w=
rote:
> > >
> > > The clkoutN names of clocks must be unique because they represent
> > > unique inputs of clock multiplexer.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b=
/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > index 73b56fc5bf58..d8e03716f5d2 100644
> > > --- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
> > > @@ -53,8 +53,10 @@ properties:
> > >        List of clock names for particular CLKOUT mux inputs
> > >      minItems: 1
> > >      maxItems: 32
> > > -    items:
> > > -      pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > +    allOf:
> > > +      - items:
> > > +          pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
> > > +      - uniqueItems: true
> >
> > You shouldn't need the 'allOf', just add uniqueItems at the same level =
as items.
>
> If you mean something like:
>   56     uniqueItems: true
>   57     items:
>   58       pattern: '^clkout([0-9]|[12][0-9]|3[0-1])$'
>
> Then the dt_binding_check fails:
>
> dev/linux/Documentation/devicetree/bindings/arm/samsung/pmu.yaml: propert=
ies:clock-names:
> 'uniqueItems' is not one of ['$ref', 'additionalItems', 'additionalProper=
ties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'd=
eprecated', 'description', 'else', 'enum', 'items', 'if', 'minItems', 'mini=
mum', 'maxItems', 'maximum', 'not', 'oneOf', 'pattern', 'patternProperties'=
, 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedPropert=
ies']

I can add it.

The other option is to fix this in the clock schema. I'm not sure if
there's a need for duplicate clock-names. Seems unlikely. I'll test
that.

Rob
