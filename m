From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB board
Date: Fri, 2 Aug 2019 16:38:16 -0600
Message-ID: <CAL_JsqL++GZBxczxePni9ysNq06kObB4EzJEi1e4M=PurPZFgQ@mail.gmail.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com> <20190802194702.30249-2-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802194702.30249-2-stefan-gabriel.mirea@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Eddy Petrisor <eddy.petrisor@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 2, 2019 at 1:47 PM Stefan-gabriel Mirea
<stefan-gabriel.mirea@nxp.com> wrote:
>
> From: Eddy Petri=C8=99or <eddy.petrisor@nxp.com>
>
> Add entry for the NXP S32V234 Customer Evaluation Board to the board/SoC
> bindings.
>
> Signed-off-by: Eddy Petri=C8=99or <eddy.petrisor@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 7294ac36f4c0..104d60a11177 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -309,4 +309,10 @@ properties:
>                - fsl,ls2088a-rdb
>            - const: fsl,ls2088a
>
> +      - description: S32V234 Customer Evaluation Board

Most of the entries in this file are for all the boards for an SoC.

> +        items:
> +          - enum:
> +              - fsl,s32v234-evb

If that's not going to be the case here, you can use 'const' here.

> +          - const: fsl,s32v234
> +
>  ...
> --
> 2.22.0
>
