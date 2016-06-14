From: Dinh Nguyen <dinguyen@kernel.org>
Subject: [RFC RESEND] serial: 8250: fix regression in 8250 uart driver
Date: Mon, 13 Jun 2016 21:59:49 -0500
Message-ID: <575F7325.3030907@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andriy.shevchenko@linux.intel.com
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Apologies, but my original email bounced for Andy and Heikki, resending.
----

Hi Andy,

I saw that you have discovered that commit ec5a11a91eec ("serial: 8250:
Validate dmaengine rx chan meets requirements") introduced a regression
in the 8250 uart driver. For SoCFPGA platform, I am seeing this error:

[    5.541751] ttyS0 - failed to request DMA

Reverting the commit ec5a11a91eec removes the error.

I saw that you started the discussion, but I didn't see that a patch was
included[1].

The following patch seems to fix the error, but I'm not sure if it's the
same fix that you had in mind.

Thanks,
Dinh

[1] http://marc.info/?l=linux-serial&m=146254187602862&w=2

---------------8<------------
diff --git a/drivers/tty/serial/8250/8250_dma.c
b/drivers/tty/serial/8250/8250_dma.c
index 7f33d1c..847a203 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -176,7 +176,7 @@ int serial8250_request_dma(struct uart_8250_port *p)
        ret = dma_get_slave_caps(dma->rxchan, &caps);
        if (ret)
                goto release_rx;
-       if (!caps.cmd_pause || !caps.cmd_terminate ||
+       if ((!caps.cmd_pause || !caps.cmd_terminate) &&
            caps.residue_granularity ==
DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
                ret = -EINVAL;
                goto release_rx;
