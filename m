X-Greylist: delayed 12536 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 12:14:53 PST
Received: from 13.mo581.mail-out.ovh.net (13.mo581.mail-out.ovh.net [87.98.150.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F564CE
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 12:14:53 -0800 (PST)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.16.164])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id AFD892911F
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 16:38:32 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-xs2pd (unknown [10.110.115.64])
	by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 684E11FEB1;
	Mon,  4 Dec 2023 16:38:30 +0000 (UTC)
Received: from etezian.org ([37.59.142.108])
	by ghost-submission-6684bf9d7b-xs2pd with ESMTPSA
	id +XHROoYAbmXEPgEAARI0UQ
	(envelope-from <andi@etezian.org>); Mon, 04 Dec 2023 16:38:30 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-108S002df2c8a09-4776-4603-a36c-0a28285054ac,
                    728393C84468B0D913C64D460E7D07E4521566EB) smtp.auth=andi@etezian.org
X-OVh-ClientIp:178.238.172.4
From: Andi Shyti <andi.shyti@kernel.org>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 2/2] serial: ma35d1: Improve logging for out-of-bound console setup
Date: Mon,  4 Dec 2023 17:38:04 +0100
Message-ID: <20231204163804.1331415-3-andi.shyti@kernel.org>
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
X-Ovh-Tracer-Id: 38280596975913543
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepgfduveejteegteelhfetueetheegfeehhfektddvleehtefhheevkeduleeuueevnecukfhppeduvdejrddtrddtrddupddujeekrddvfeekrddujedvrdegpdefjedrheelrddugedvrddutdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghnughisegvthgviihirghnrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht

An out-of-bound index results in an error and should not be
logged merely as a debug message; it requires at least a warning
level. Therefore, use pr_warn() instead of pr_debug.

Additionally, the log message itself has been improved for
clarity.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/tty/serial/ma35d1_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 21b574f78b861..bcc402b4c0b2f 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -599,7 +599,8 @@ static int __init ma35d1serial_console_setup(struct console *co, char *options)
 	int flow = 'n';
 
 	if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
-		pr_debug("Console Port%x out of range\n", co->index);
+		pr_warn("Failed to write on cononsole port %x, out of range\n",
+			co->index);
 		return -EINVAL;
 	}
 
-- 
2.43.0

