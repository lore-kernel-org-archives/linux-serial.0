From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
Date: Mon, 12 Jan 2015 16:08:38 +0000
Message-ID: <1421078918.31978.32.camel@linux.intel.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
	 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
	 <3712986.8SuKNvhKTk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3712986.8SuKNvhKTk@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Eddie Huang <eddie.huang@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On Mon, 2015-01-12 at 16:35 +0100, Arnd Bergmann wrote:
> On Monday 12 January 2015 21:08:21 Eddie Huang wrote:
> > Add earlycon support not only baudrate option, but also add noinit option.
> > If use noinit option, 8250 earlycon will not init serial hardware and use
> > loader setting.
> > 
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> 
> I probably missed something in the previous discussion, but why is
> "noinit" not just the default? I believe that is how we handle early
> serial ports on PowerPC, and I see no downsides to it.

Most PC hardware at least needs the port initialised to use it. It won't
have been configured by the firmware in many cases.

Alan
