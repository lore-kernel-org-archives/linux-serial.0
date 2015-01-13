From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support
 noinit option
Date: Tue, 13 Jan 2015 09:05:29 +0800
Message-ID: <1421111129.10374.4.camel@mtksdaap41>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
 <3712986.8SuKNvhKTk@wuerfel>  <1421078918.31978.32.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421078918.31978.32.camel@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, linux-serial@vger.kernel.org, "Joe.C" <yingjoe.chen@mediatek.com>, devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On Mon, 2015-01-12 at 16:08 +0000, Alan Cox wrote:
> On Mon, 2015-01-12 at 16:35 +0100, Arnd Bergmann wrote:
> > On Monday 12 January 2015 21:08:21 Eddie Huang wrote:
> > > Add earlycon support not only baudrate option, but also add noinit option.
> > > If use noinit option, 8250 earlycon will not init serial hardware and use
> > > loader setting.
> > > 
> > > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > 
> > I probably missed something in the previous discussion, but why is
> > "noinit" not just the default? I believe that is how we handle early
> > serial ports on PowerPC, and I see no downsides to it.
> 
> Most PC hardware at least needs the port initialised to use it. It won't
> have been configured by the firmware in many cases.
> 

Sorry no continue discuss in previous series. Since other 8250 user may
already depend on current init behavior, I think it's better to keep it
and add noinit by extra setting.

Eddie 
