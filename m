Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05694C43334
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 10:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiFHKRf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiFHKRZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 06:17:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF428278305
        for <linux-serial@vger.kernel.org>; Wed,  8 Jun 2022 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654682681; x=1686218681;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=xL5HY8syflbBz2G3x/JfLtJ3+JZNC3D33fpcZSONM68=;
  b=Br2KRykPfc9x1VuuhLncxKbKap/mztB8a1IcVmX4zY1SYQJRYjc50Z5I
   dRQKPhcxgemIQUou8dmlJyRestobozYDN59Gs/w4Oz0hFh7v7j/zwTZkF
   a+PEFy6ERy45OsJ/VHTtui9LsiFA+zpucvsTW1BPPxTFIbBFbG7xMwBma
   0sjY0aNIUS3QKUYxojccqPLrdAqrIrj0ftoGhksoettBAWKs6A1neM5lh
   QVRxH3M0GffuCGFjrVvUZN8kLblalX2p0DWxpF/zCFuQ9OF/wuksDVe0M
   NZzk1DXerVIB0ID72nih3JTp8i5MEg1uWSrBbLAMVClL9ngEFsoh2FDLV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277684098"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="277684098"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 03:04:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="636727616"
Received: from bmichals-mobl.ger.corp.intel.com ([10.252.57.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 03:04:39 -0700
Date:   Wed, 8 Jun 2022 13:04:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Nuno_Gon=E7alves?= <nunojpg@gmail.com>
cc:     Tomasz Mon <tomasz.mon@camlingroup.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: pl011: UPSTAT_AUTORTS requires
 .throttle/unthrottle
In-Reply-To: <CAEXMXLRrysT_+RUZ4sg6DGT8Hzdv2jrzX2eZ2Z0mPu39y3-m7g@mail.gmail.com>
Message-ID: <ea30fbc2-6535-9fdd-6691-9bb7baa56ec2@linux.intel.com>
References: <45e1eac1-1818-1f8c-6168-cff6be6427af@linux.intel.com> <CAEXMXLRrysT_+RUZ4sg6DGT8Hzdv2jrzX2eZ2Z0mPu39y3-m7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-683054541-1654681523=:1676"
Content-ID: <fe4858a-ddba-9671-a55c-abffe5ee6c24@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-683054541-1654681523=:1676
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <ff36844c-85b4-3710-3451-215285ea994@linux.intel.com>

On Wed, 8 Jun 2022, Nuno Gonçalves wrote:

> On Fri, Apr 29, 2022 at 12:24 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > The driver must provide throttle and unthrottle in uart_ops when it
> > sets UPSTAT_AUTORTS. Add them using existing stop_rx &
> > enable_interrupts functions.
> >
> > Compile tested (w/o linking).
> >
> > Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
> > Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto
> >                      RTS status)
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >
> > ---
> >
> > Maybe this one is the correct solution (I'm not able to test on the real
> > hw though)?
> 
> I still get a crash with your patch:
> 
> [  827.145500] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [  827.154515] Mem abort info:
> [  827.157394]   ESR = 0x86000005
> [  827.160538]   EC = 0x21: IABT (current EL), IL = 32 bits
> [  827.165979]   SET = 0, FnV = 0
> [  827.169115]   EA = 0, S1PTW = 0
> [  827.172332]   FSC = 0x05: level 1 translation fault
> [  827.177320] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000043f2000
> [  827.183900] [0000000000000000] pgd=0000000000000000,
> p4d=0000000000000000, pud=0000000000000000
> [  827.192815] Internal error: Oops: 86000005 [#1] PREEMPT SMP
> [  827.198488] CPU: 2 PID: 372 Comm: kworker/u8:0 Tainted: G        W
>        5.18.2 #1
> [  827.206356] Hardware name: Raspberry Pi Compute Module 3 Plus Rev 1.0 (DT)
> [  827.213339] Workqueue: events_unbound flush_to_ldisc
> [  827.218407] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  827.225481] pc : 0x0
> [  827.227701] lr : uart_throttle+0x94/0x160

Hi Nuno,

It seems I managed to put the .throttle and .unthrottle into the wrong 
ops within amba-pl011.c. I'm sorry about the extra trouble. This patch has 
a bit higher likelihood of doing something useful to the problem:

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[PATCH v3] serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle

The driver must provide throttle and unthrottle in uart_ops when it
sets UPSTAT_AUTORTS. Add them using existing stop_rx &
enable_interrupts functions.

Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto RTS status)
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/serial/amba-pl011.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 97ef41cb2721..16a21422ddce 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1367,6 +1367,15 @@ static void pl011_stop_rx(struct uart_port *port)
 	pl011_dma_rx_stop(uap);
 }
 
+static void pl011_throttle_rx(struct uart_port *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	pl011_stop_rx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static void pl011_enable_ms(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1788,9 +1797,10 @@ static int pl011_allocate_irq(struct uart_amba_port *uap)
  */
 static void pl011_enable_interrupts(struct uart_amba_port *uap)
 {
+	unsigned long flags;
 	unsigned int i;
 
-	spin_lock_irq(&uap->port.lock);
+	spin_lock_irqsave(&uap->port.lock, flags);
 
 	/* Clear out any spuriously appearing RX interrupts */
 	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
@@ -1812,7 +1822,14 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
 	pl011_write(uap->im, uap, REG_IMSC);
-	spin_unlock_irq(&uap->port.lock);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+}
+
+static void pl011_unthrottle_rx(struct uart_port *port)
+{
+	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
+
+	pl011_enable_interrupts(uap);
 }
 
 static int pl011_startup(struct uart_port *port)
@@ -2225,6 +2242,8 @@ static const struct uart_ops amba_pl011_pops = {
 	.stop_tx	= pl011_stop_tx,
 	.start_tx	= pl011_start_tx,
 	.stop_rx	= pl011_stop_rx,
+	.throttle	= pl011_throttle_rx,
+	.unthrottle	= pl011_unthrottle_rx,
 	.enable_ms	= pl011_enable_ms,
 	.break_ctl	= pl011_break_ctl,
 	.startup	= pl011_startup,

-- 
tg: (f2906aa86338..) pl011/add-throttle (depends on: tty-next)
--8323329-683054541-1654681523=:1676--
