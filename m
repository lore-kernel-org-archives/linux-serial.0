From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
Date: Wed, 23 Jan 2019 17:10:07 -0800
Message-ID: <CAE=gft5+OJCHTVszSW2Tt9HX3UA-LuTzK95Q4-R3v=DUqff9OA@mail.gmail.com>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org> <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alok Chauhan <alokc@codeaurora.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Georgi Djakov <georgi.djakov@linaro.org>, Doug Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 21, 2019 at 10:34 PM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> Add documentation for the interconnect and interconnect-names bindings
> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> index dab7ca9..44d7e02 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -17,6 +17,12 @@ Required properties if child node exists:
>  - #address-cells:      Must be <1> for Serial Engine Address
>  - #size-cells:                 Must be <1> for Serial Engine Address Size
>  - ranges:              Must be present
> +- interconnects:       phandle to a interconnect provider. Please refer
> +                       ../interconnect/interconnect.txt for details.

This path to the interconnect documentation is not correct.
