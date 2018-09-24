From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH 13/14] serial: lantiq: Change init_lqasc to static declaration
Date: Mon, 24 Sep 2018 18:28:02 +0800
Message-ID: <20180924102803.30263-14-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, hauke.mehrtens@intel.com
Cc: Songjun Wu <songjun.wu@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

init_lqasc() is only used internally, change to static declaration.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index ba0c70b16bda..e052b69ceb98 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -784,7 +784,7 @@ static struct platform_driver lqasc_driver = {
 	},
 };
 
-int __init
+static int __init
 init_lqasc(void)
 {
 	int ret;
-- 
2.11.0
