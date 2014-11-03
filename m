From: Konrad Zapalowicz <bergo.torino@gmail.com>
Subject: [PATCH 5/5] drivers: serial: jsm: Remove FSF address from the file
 documentation/header
Date: Mon,  3 Nov 2014 01:06:30 +0100
Message-ID: <1414973190-10153-6-git-send-email-bergo.torino@gmail.com>
References: <1414973190-10153-1-git-send-email-bergo.torino@gmail.com>
 <1414973190-10153-2-git-send-email-bergo.torino@gmail.com>
 <1414973190-10153-3-git-send-email-bergo.torino@gmail.com>
 <1414973190-10153-4-git-send-email-bergo.torino@gmail.com>
 <1414973190-10153-5-git-send-email-bergo.torino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1414973190-10153-5-git-send-email-bergo.torino@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org, jslaby@suse.cz, cascardo@linux.vnet.ibm.com
Cc: devel@driverdev.osuosl.org, lidza.louina@gmail.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Konrad Zapalowicz <bergo.torino@gmail.com>
List-Id: linux-serial@vger.kernel.org

This commit removes the address of Free Software Foundation from each
of the mentioned file in order to suppress the checkpatch warning.

Signed-off-by: Konrad Zapalowicz <bergo.torino@gmail.com>
---
 drivers/tty/serial/jsm/jsm.h        | 5 -----
 drivers/tty/serial/jsm/jsm_cls.c    | 5 -----
 drivers/tty/serial/jsm/jsm_driver.c | 5 -----
 drivers/tty/serial/jsm/jsm_neo.c    | 5 -----
 drivers/tty/serial/jsm/jsm_tty.c    | 5 -----
 5 files changed, 25 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm.h b/drivers/tty/serial/jsm/jsm.h
index 662523d..72ed5c1 100644
--- a/drivers/tty/serial/jsm/jsm.h
+++ b/drivers/tty/serial/jsm/jsm.h
@@ -13,11 +13,6 @@
  * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  * PURPOSE.  See the GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 * Temple Place - Suite 330, Boston,
- * MA  02111-1307, USA.
- *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
  * Wendy Xiong   <wendyx@us.ibm.com>
diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 949e080..c6f450c 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -12,11 +12,6 @@
  * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  * PURPOSE.  See the GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *
  *	NOTE TO LINUX KERNEL HACKERS:  DO NOT REFORMAT THIS CODE!
  *
  *	This is shared code between Digi's CVS archive and the
diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 0927ddf..efbd87a 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -13,11 +13,6 @@
  * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  * PURPOSE.  See the GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 * Temple Place - Suite 330, Boston,
- * MA  02111-1307, USA.
- *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
  * Wendy Xiong   <wendyx@us.ibm.com>
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index dfaf488..dc2cd90 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -13,11 +13,6 @@
  * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  * PURPOSE.  See the GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 * Temple Place - Suite 330, Boston,
- * MA  02111-1307, USA.
- *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
  * Wendy Xiong   <wendyx@us.ibm.com>
diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index f9b1fbd..8a71960 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -13,11 +13,6 @@
  * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  * PURPOSE.  See the GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 * Temple Place - Suite 330, Boston,
- * MA  02111-1307, USA.
- *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
  * Ananda Venkatarman <mansarov@us.ibm.com>
-- 
1.9.1
