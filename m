From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: STi: Fix aliases property name for STi boards
Date: Mon, 5 Mar 2018 09:28:08 -0600
Message-ID: <CABGGiszEcvKHGE54vOXPBUJeReAKbgmrxRyRxNfQQoL6D54GCw@mail.gmail.com>
References: <1520262025-21088-1-git-send-email-patrice.chotard@st.com> <1520262025-21088-2-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520262025-21088-2-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patrice.chotard@st.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 5, 2018 at 9:00 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name must
> be lowercase only.
> This allows to fix following warnings when compiling dtb
> with W=1 option :

I'm so glad to see fixes before the dtc update landed in the kernel tree!

> arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
>  arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
>  arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
>  arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
> index c8ad905d0309..fa1186af6574 100644
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@ -14,7 +14,7 @@
>         compatible = "st,stih407-b2120", "st,stih407";
>
>         chosen {
> -               bootargs = "console=ttyAS0,115200 clk_ignore_unused";
> +               bootargs = "console=ttyas0,115200 clk_ignore_unused";

The kernel change for this is an ABI breakage both DT <-> kernel and
kernel <-> userspace.

Really, if you are okay with doing this, you should change it to ttySx IMO.

>                 linux,stdout-path = &sbc_serial0;

And since you have this, you don't even need the console praram.

>         };
>
> @@ -24,7 +24,7 @@
>         };
>
>         aliases {
> -               ttyAS0 = &sbc_serial0;
> +               ttyas0 = &sbc_serial0;

The correct fix is use "serialN" for aliases.

I have a check for only known alias names which would give a better
warning, but David thought it was too restrictive.

>                 ethernet0 = &ethernet0;
>         };
>
