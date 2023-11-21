Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733E38F8D
	for <linux-serial@vger.kernel.org>; Tue, 21 Nov 2023 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMaaAFxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1A6C433C8;
	Tue, 21 Nov 2023 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700558595;
	bh=1ot3xOBoOP7h0U8F/4uFP8Qnn04pPCBCsYAQSIl1nS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMaaAFxtaDDQ56o7fXs0QGyJcFgyPvsmGh4mwdScBGVHv6QbGWvjUyLtBXJ/f+KuA
	 ES0RVOIH2egtSF87/OHQecYS33l9Spw874MqkkK61gISBS5zFMgvG9tTjmiWBAvPTB
	 ATJPBITN4yxZB9bPfXrJfbnzHQp0FdmotvxpyqJW/ocA/UfrLslKHaIQbbAdaby4zp
	 QwjGZqMr4CZ0qPCu/+NaBP2kBb4DFEHQZBwpcBaIN2IJ8SaG75NZWm/MJfKYBLjObi
	 uCBIjbzCMh+ZNi5Z6jiBQQRevsVtxJ8GWrV4auGzSjcn5+SL6YORjtdCp56fcZ1ApB
	 ockXOFliS6RKQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/17] tty: ehv_bytecha: use memcpy_and_pad() in local_ev_byte_channel_send()
Date: Tue, 21 Nov 2023 10:22:48 +0100
Message-ID: <20231121092258.9334-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a helper for memcpy(buffer)+memset(the_rest). Use it for
simplicity.

And add a comment why we are doing the copy in the first place.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/ehv_bytechan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index a067628e01c8..cc9f4338da60 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -143,9 +143,12 @@ static unsigned int local_ev_byte_channel_send(unsigned int handle,
 	char buffer[EV_BYTE_CHANNEL_MAX_BYTES];
 	unsigned int c = *count;
 
+	/*
+	 * ev_byte_channel_send() expects at least EV_BYTE_CHANNEL_MAX_BYTES
+	 * (16 B) in the buffer. Fake it using a local buffer if needed.
+	 */
 	if (c < sizeof(buffer)) {
-		memcpy(buffer, p, c);
-		memset(&buffer[c], 0, sizeof(buffer) - c);
+		memcpy_and_pad(buffer, sizeof(buffer), p, c, 0);
 		p = buffer;
 	}
 	return ev_byte_channel_send(handle, count, p);
-- 
2.42.1

