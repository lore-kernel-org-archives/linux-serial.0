X-Greylist: delayed 923 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 08:53:51 PST
Received: from 3.mo560.mail-out.ovh.net (3.mo560.mail-out.ovh.net [46.105.58.226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2CBB
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 08:53:51 -0800 (PST)
Received: from director2.ghost.mail-out.ovh.net (unknown [10.109.146.53])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 48D9428B2B
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 16:38:26 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-jf6x6 (unknown [10.110.103.36])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 49EEA1FDAC;
	Mon,  4 Dec 2023 16:38:24 +0000 (UTC)
Received: from etezian.org ([37.59.142.101])
	by ghost-submission-6684bf9d7b-jf6x6 with ESMTPSA
	id 1L9OGoAAbmU3HQEAUZVF/w
	(envelope-from <andi@etezian.org>); Mon, 04 Dec 2023 16:38:24 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004ca7d984c-7908-45d8-8a25-20e6dd06602f,
                    728393C84468B0D913C64D460E7D07E4521566EB) smtp.auth=andi@etezian.org
X-OVh-ClientIp:178.238.172.4
From: Andi Shyti <andi.shyti@kernel.org>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 1/2] serial: ma35d1: Validate console index before assignment
Date: Mon,  4 Dec 2023 17:38:03 +0100
Message-ID: <20231204163804.1331415-2-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204163804.1331415-1-andi.shyti@kernel.org>
References: <20231204163804.1331415-1-andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 36591748781640263
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepgfduveejteegteelhfetueetheegfeehhfektddvleehtefhheevkeduleeuueevnecukfhppeduvdejrddtrddtrddupddujeekrddvfeekrddujedvrdegpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghnughisegvthgviihirghnrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht

The console is immediately assigned to the ma35d1 port without
checking its index. This oversight can lead to out-of-bounds
errors when the index falls outside the valid '0' to
MA35_UART_NR range. Such scenario trigges ran error like the
following:

 UBSAN: array-index-out-of-bounds in drivers/tty/serial/ma35d1_serial.c:555:51
 index -1 is out of range for type 'uart_ma35d1_port [17]

Check the index before using it and bail out with a warning.

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>
Cc: <stable@vger.kernel.org> # v6.5+
---
 drivers/tty/serial/ma35d1_serial.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index a6a7c405892e8..21b574f78b861 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -552,11 +552,19 @@ static void ma35d1serial_console_putchar(struct uart_port *port, unsigned char c
  */
 static void ma35d1serial_console_write(struct console *co, const char *s, u32 count)
 {
-	struct uart_ma35d1_port *up = &ma35d1serial_ports[co->index];
+	struct uart_ma35d1_port *up;
 	unsigned long flags;
 	int locked = 1;
 	u32 ier;
 
+	if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
+		pr_warn("Failed to write on ononsole port %x, out of range\n",
+			co->index);
+		return;
+	}
+
+	up = &ma35d1serial_ports[co->index];
+
 	if (up->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-- 
2.43.0

