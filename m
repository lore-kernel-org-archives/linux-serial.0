From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
Date: Tue, 11 Feb 2014 01:50:14 +0000
Message-ID: <c1c2915231eb4595b89327e589bc521d@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <20140127075025.GC4765@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140127075025.GC4765@S2101-09.ap.freescale.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi, Shawn

Here I just want the DMA be a selectable property for each board. 
Is it suitable?

> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo@linaro.org]
> Sent: Monday, January 27, 2014 3:50 PM
> To: Yuan Yao-B46683
> Cc: gregkh@linuxfoundation.org; linux@arm.linux.org.uk; arnd@arndb.de;
> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org; linux-
> serial@vger.kernel.org
> Subject: Re: [PATCH v4 0/3] serial: fsl_lpuart: add DMA support
> 
> On Wed, Jan 22, 2014 at 12:09:30PM +0800, Yuan Yao wrote:
> > Changed in v4:
> > - Move dma properties from dtsi to dts.
> 
> Why this change?  DMA is a SoC level resource rather than board one.
> 
> Shawn
