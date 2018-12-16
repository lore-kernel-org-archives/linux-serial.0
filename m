From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Sun, 16 Dec 2018 21:31:34 +0000
Message-ID: <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
Content-Language: en-US
Content-ID: <5BE0F6BB5B7C8A4F9E9B5ACF9E3759B0@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Marek,

On Sun, Dec 16, 2018 at 09:32:19PM +0100, Marek Vasut wrote:
> I am unable to test it on such a short notice as I'm currently ill, so I
> cannot tell if your change breaks the OMAP3/AM335x boards or not. Given
> that there are very few CI20 boards in use, I'd like to ask you for some
> extra time to investigate this on the OMAP3 too.

I'm sorry to hear that you're ill, but your patch is getting awfully
close to becoming part of a stable kernel release & it causes
regressions. Even if it didn't break a board I use, I think the patch
would be broken & risky for the reasons I outlined in my revert's commit
message.

Ultimately it's Greg's decision but it sounds like you're asking me to
say it's OK to break the JZ4780 in a stable kernel with a patch that I
think would be risky anyway, and I won't do that.

> btw what strikes me as curious is that this patch emerged shortly after
> Ezequiel re-posted the CI20 U-Boot patches after an year-long hiatus, is
> it somehow related ?

Not at all - I regularly test on Ci20 & found this breakage whilst
testing Paul Cercueil's Ingenic TCU patchset v8 [1]. Using a Ci20 with
mainline kernels doesn't rely on Ezequiel's U-Boot work, and indeed I
generally boot using my ci20-usb-boot tool [2] so U-Boot isn't involved
at all.

Now my Ci20 testing isn't automated so it tends to happen mostly when
there are obvious changes to the board or SoC support, but it should
become more automated soon. Kevin Hilman just got a Ci40 working with
kernelci.org infrastructure & I hope we can get Ci20 & other boards
included soon too, either via existing kernelci.org labs or by setting
up a new one.

Thanks,
    Paul

[1] https://lore.kernel.org/linux-mips/20181212220922.18759-1-paul@crapouil=
lou.net/T/#t
[2] https://github.com/paulburton/ci20-tools
