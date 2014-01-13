From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] serial: fsl_lpuart: add eDMA support
Date: Mon, 13 Jan 2014 09:45:52 +0100
Message-ID: <201401130945.53447.arnd@arndb.de>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
 <201401090956.38789.arnd@arndb.de>
 <1d437762499348b6aeca3621b151d770@BL2PR03MB338.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1d437762499348b6aeca3621b151d770@BL2PR03MB338.namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Yao Yuan <yao.yuan@freescale.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Monday 13 January 2014, Yao Yuan wrote:
> I need the functions like this:
> Static A()
> {
>         if(condition) 
>                 B();
> }
> Static B()
> {
>         callback:C();
> }
> Static C()
> {
>         if(condition)
>                 A();
> }
> 
> So, it's hard to avoid forward declarations for "static" functions.
> I'm very glad for a better way.


Ok, that makes sense. It is an unusual pattern from the dmaengine API,
most drivers can more easily do without forward declarations. I think
you'd be able to avoid the lpuart_prepare_tx() forward declation, but
that wouldn't actually improve readability in this case. Just add a
comment above the declarations describing that they are needed for the
callbacks and that no recursion is possible. The important problem
to avoid really is having unbounded recursion between multple
functions, because that could blow the kernel stack size limit.

A small improvement that you can try is to have forward declarations
for the completion functions rather than the dma start functions, but
it won't be a big difference in the end. Your choice.

	Arnd
