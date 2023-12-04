X-Greylist: delayed 6600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 11:07:55 PST
Received: from 20.mo582.mail-out.ovh.net (20.mo582.mail-out.ovh.net [178.32.124.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF82188
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 11:07:55 -0800 (PST)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.20.107])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id D23AD25051
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 16:38:19 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-9k8qw (unknown [10.109.138.60])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C50471FDDB;
	Mon,  4 Dec 2023 16:38:16 +0000 (UTC)
Received: from etezian.org ([37.59.142.102])
	by ghost-submission-6684bf9d7b-9k8qw with ESMTPSA
	id oPzWM3gAbmUIfgAA3fLkWg
	(envelope-from <andi@etezian.org>); Mon, 04 Dec 2023 16:38:16 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R00487f7c05c-cd1b-45e6-a84e-d0be2fe0901c,
                    728393C84468B0D913C64D460E7D07E4521566EB) smtp.auth=andi@etezian.org
X-OVh-ClientIp:178.238.172.4
From: Andi Shyti <andi.shyti@kernel.org>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 0/2] serial ma35d1 imrpovements
Date: Mon,  4 Dec 2023 17:38:02 +0100
Message-ID: <20231204163804.1331415-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 34621422958217799
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnheptdevueeiheeftedujefhheelieejvdevteelfefhheeutdelkedtveejudejgfdvnecukfhppeduvdejrddtrddtrddupddujeekrddvfeekrddujedvrdegpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeorghnughisegvthgviihirghnrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsvghrihgrlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht

Hi,

Just a couple of improvements after running through a failure
for the serial ma35d1 driver.

Thanks,
Andi

Andi Shyti (2):
  serial: ma35d1: Validate console index before assignment
  serial: ma35d1: Improve logging for out-of-bound console setup

 drivers/tty/serial/ma35d1_serial.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.43.0

