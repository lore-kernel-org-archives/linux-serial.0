From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/76] serial: mrst_max3110: make buffer larger
Date: Wed, 16 Mar 2011 14:11:37 -0700
Message-ID: <1300309966-5745-7-git-send-email-gregkh@suse.de>
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
Cc: stable@kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Dan Carpenter <error27@gmail.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>

This is used to store the spi_device ->modalias so they have to be the same
size.  SPI_NAME_SIZE is 32.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/mrst_max3110.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index b62857b..37e13c3 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -51,7 +51,7 @@
 struct uart_max3110 {
 	struct uart_port port;
 	struct spi_device *spi;
-	char name[24];
+	char name[SPI_NAME_SIZE];
 
 	wait_queue_head_t wq;
 	struct task_struct *main_thread;
-- 
1.7.4.1
