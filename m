From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/6] DMA: AT91: Serial: Add parameter for serial dma use
Date: Thu, 22 Nov 2012 08:44:33 +0100
Message-ID: <20121122074433.GZ4398@game.jcrosoft.org>
References: <1351501754-25028-1-git-send-email-elen.song@atmel.com>
 <1351501773-29024-1-git-send-email-elen.song@atmel.com>
 <20121029114221.GA31214@game.jcrosoft.org>
 <508F7629.2040905@atmel.com> <50ADD70B.6070801@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <50ADD70B.6070801@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Elen Song <elen.song@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 15:40 Thu 22 Nov     , Elen Song wrote:
> On 2012-10-30 14:39, Elen Song wrote:
> >On 2012-10-29 19:42, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>On 17:09 Mon 29 Oct     , Elen Song wrote:
> >>>Signed-off-by: Elen Song <elen.song@atmel.com>
> >>>---
> >>>  arch/arm/mach-at91/include/mach/board.h |    2 ++
> >>>  drivers/tty/serial/atmel_serial.c       |    1 +
> >>>  include/linux/platform_data/dma-atmel.h |   10 ++++++++++
> >>>  3 files changed, 13 insertions(+)
> >>you will have to rebase this over a clean if the platofrm_data
> >>I'll send today
> >>or tomorrow that will move all the platform_data to inclide/linux
> >
> >ok, please cc me in the mail list.
> Hi JC:
> 
>     any more feedback ?
no time finish to prepare the 3.8 will have to wait after

Best Regards,
J.
