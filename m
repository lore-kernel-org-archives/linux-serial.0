From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 26/76] serial: also set the uartclk value in resume
	after goes to highspeed
Date: Wed, 16 Mar 2011 14:11:56 -0700
Message-ID: <1300309966-5745-26-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
	<1300309966-5745-1-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <greg@kroah.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Yin Kangkai <kangkai.yin@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, stable@kernel.org
List-Id: linux-serial@vger.kernel.org

From: Yin Kangkai <kangkai.yin@linux.intel.com>

For any reason if the NS16550A was not work in high speed mode (e.g. we hold
NS16550A from going to high speed mode in autoconfig_16550a()), now we are
resume from suspend, we should also set the uartclk to the correct
value. Otherwise it is still the old 1843200 and that will bring issues.

CC: Greg Kroah-Hartman <greg@kroah.com>
CC: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
CC: stable@kernel.org
Signed-off-by: Yin Kangkai <kangkai.yin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 3975df6..c10a6a9 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -3036,6 +3036,7 @@ void serial8250_resume_port(int line)
 		serial_outp(up, 0x04, tmp);
 
 		serial_outp(up, UART_LCR, 0);
+		up->port.uartclk = 921600*16;
 	}
 	uart_resume_port(&serial8250_reg, &up->port);
 }
-- 
1.7.4.1
