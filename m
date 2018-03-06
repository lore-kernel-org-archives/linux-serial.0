From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] ARM: dts: STi: Remove useless stdout-path for STi boards
Date: Tue, 6 Mar 2018 07:26:22 -0600
Message-ID: <CAL_Jsq+-C5h1-xLOB39bhSsn9JR31UaEQL+cRwydD0a4w6sYNw@mail.gmail.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com> <1520323650-11030-3-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520323650-11030-3-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrice Chotard <patrice.chotard@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 6, 2018 at 2:07 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> As serial interface is already specified into bootargs,
> stdout-path can be removed.

Wrong way around. stdout-path is preferred over using console in bootargs.

>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>
> v2: _ none
>
>  arch/arm/boot/dts/stih407-b2120.dts | 1 -
>  arch/arm/boot/dts/stih410-b2120.dts | 1 -
>  arch/arm/boot/dts/stih410-b2260.dts | 1 -
>  arch/arm/boot/dts/stih418-b2199.dts | 1 -
>  4 files changed, 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
> index 2c4d6033b448..074b4cd0ca89 100644
> --- a/arch/arm/boot/dts/stih407-b2120.dts
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@ -15,7 +15,6 @@
>
>         chosen {
>                 bootargs = "console=serial0,115200 clk_ignore_unused";
> -               stdout-path = &sbc_serial0;
>         };
>
>         memory@40000000 {
> diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
> index 5422850641e8..eae3050984d0 100644
> --- a/arch/arm/boot/dts/stih410-b2120.dts
> +++ b/arch/arm/boot/dts/stih410-b2120.dts
> @@ -15,7 +15,6 @@
>
>         chosen {
>                 bootargs = "console=serial0,115200 clk_ignore_unused";
> -               stdout-path = &sbc_serial0;
>         };
>
>         memory@40000000 {
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index ca347160e35d..c26e388bd1a4 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -16,7 +16,6 @@
>
>         chosen {
>                 bootargs = "console=serial1,115200 clk_ignore_unused";
> -               stdout-path = &uart1;
>         };
>
>         memory@40000000 {
> diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
> index dbf7bb704a1a..d948f774fee7 100644
> --- a/arch/arm/boot/dts/stih418-b2199.dts
> +++ b/arch/arm/boot/dts/stih418-b2199.dts
> @@ -15,7 +15,6 @@
>
>         chosen {
>                 bootargs = "console=serial0,115200 clk_ignore_unused";
> -               stdout-path = &sbc_serial0;
>         };
>
>         memory@40000000 {
> --
> 1.9.1
>
