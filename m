From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 3/3] arm64: dts: Add mediatek MT8173 earlycon support
Date: Wed, 29 Apr 2015 08:44:54 +0200
Message-ID: <20150429064454.GR6325@pengutronix.de>
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
 <1430228434-31779-4-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430228434-31779-4-git-send-email-eddie.huang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, srv_heupstream@mediatek.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.cz>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Wang Long <long.wanglong@huawei.com>, Kevin Cernekee <cernekee@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Cox <alan@linux.intel.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@
List-Id: linux-serial@vger.kernel.org

Hi Eddie,

On Tue, Apr 28, 2015 at 09:40:34PM +0800, Eddie Huang wrote:
> Add earlycon support to mediatek MT8173 evaluation board dts.

This is not about earlycon support. It adds the stdout-path property
which is generally about console. It only happens to used for earlycon,
but would be used as a regular console aswell if it wasn't broken for
some kernel revisisions.

>  
> -	chosen { };
> +	chosen {
> +		linux,stdout-path = &uart0;
> +	};

Please use stdout-path, without the 'linux,'.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
