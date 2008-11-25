From: Sheng Yang <sheng@linux.intel.com>
Subject: Re: [PATCH] 8250: Eliminate compile warning of 8250.c
Date: Tue, 25 Nov 2008 18:31:33 +0800
Message-ID: <200811251831.34737.sheng@linux.intel.com>
References: <1227585320-3711-1-git-send-email-sheng@linux.intel.com> <1227585503-3833-1-git-send-email-sheng@linux.intel.com> <20081125102230.791fa168@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:38145 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752284AbYKYKfS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Nov 2008 05:35:18 -0500
In-Reply-To: <20081125102230.791fa168@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tuesday 25 November 2008 18:22:30 Alan Cox wrote:
> On Tue, 25 Nov 2008 11:58:23 +0800
>
> Sheng Yang <sheng@linux.intel.com> wrote:
> > (Something wrong with encoding of the first mail...)
> >
> > The patch based on linux-2.6 upstream and elimiate this compile warning
> > info:
> >
> > drivers/serial/8250.c: In function 'serial8250_shutdown':
> > drivers/serial/8250.c:1612: warning: 'i' may be used uninitialized in
> > this function
>
> NAK - again.
>
> There is no real bug here and you risk hiding future ones. It also
> doesn't produce a warning with a modern gcc.

Can't understand initializing got "risk hiding future ones". As I know, didn't 
initialize the variable got risk hiding future random problems. If you think 
i=NULL is not enough, how about this? I don't use this version just because I 
think BUG_ON(n==null) cover this. And I don't think leave it to compiler is 
more proper here.

--
From: Sheng Yang <sheng@linux.intel.com>
Date: Tue, 25 Nov 2008 18:25:26 +0800
Subject: [PATCH 1/1] 8250: Eliminate compile warning of 8250.c

The patch based on linux-2.6 upstream and elimiate this compile warning
info:

drivers/serial/8250.c: In function 'serial8250_shutdown':
drivers/serial/8250.c:1612: warning: 'i' may be used uninitialized in this
function

Signed-off-by: Sheng Yang <sheng@linux.intel.com>
---
 drivers/serial/8250.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 303272a..c3120be 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1609,7 +1609,7 @@ static int serial_link_irq_chain(struct uart_8250_port 
*up)
 
 static void serial_unlink_irq_chain(struct uart_8250_port *up)
 {
-	struct irq_info *i;
+	struct irq_info *i = NULL;
 	struct hlist_node *n;
 	struct hlist_head *h;
 
@@ -1624,6 +1624,7 @@ static void serial_unlink_irq_chain(struct 
uart_8250_port *up)
 	}
 
 	BUG_ON(n == NULL);
+	BUG_ON(i == NULL);
 	BUG_ON(i->head == NULL);
 
 	if (list_empty(i->head))
-- 
1.5.4.5




