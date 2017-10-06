From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 16/16] arm64: dts: marvell: armada-3720-espressobin:
 fill UART nodes
Date: Fri, 6 Oct 2017 15:15:21 +0200
Message-ID: <20171006151521.440418a2@windsurf.lan>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
        <20171006101344.15590-17-miquel.raynal@free-electrons.com>
        <87fuawe8gx.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fuawe8gx.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hello,

On Fri, 06 Oct 2017 15:01:18 +0200, Gregory CLEMENT wrote:

>  /*
>   * To enable the second UART on J17 (pins 24,26) refer to the uart1
>   * node from armada-3720-db.dts.
>   * Note that TX and RX signal are the ones coming directly from the SoC:
>   * 1.8V TTL.
>   */

One issue with this comment (and Miquèl's version as well) is that it
does not explain why you don't enable this UART by default.

The real reason is in the commit log from Miquèl, and should probably
be part of the comment. Perhaps something like:

/*

 * Connector J17 (pins X, Y, Z) exposes a number of different
 * features:
 *  - UART1 (pins 24 = RX, pins 26 = TX), see armada-3720-db.dts for an
 *    example on how to enable UART1. Beware that the signals are 1.8V
 *    TTL.
 *  - SPIxyz
 *  - I2Cxyz
 */

Otherwise, it's not clear at all why you don't just enable UART1. Or
perhaps I misunderstood Miquèl's commit log ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
