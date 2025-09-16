Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF12E8B95;
	Tue, 16 Sep 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038244; cv=none; b=fUR59QGBQFe7qxIVvKA8Pe1bj9D+F9Kqmsc1uzMiLN2fdXy39HGsKEQLS5c0fxttnem73+urhoJvmq9dLmSNZm+mBrtUlQKG1NUiKgXz++1ycVtwVQSqdGcBw9HiDPEjyMO1Kf9ptK7H2TjbWKOxe6PwfH8cL7l8CCETOAEVpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038244; c=relaxed/simple;
	bh=f3TpM0q/jbGHwcep8aGvrDILBW4ci9MLRRWsq0hf+Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cpbZN8x4SlodZwQMoiYxsPqataKnsYIsZCH9zmoqEdWOWIzD1SDuu8mFcuGu+cve6viyiditIm6jaxmzINpOur94HKe3dVeBlT2FVK6QnlzUhMdBvQ+FgLDdyyn394ZXo4OE+85hUyEgQFQcceyBaZ5QmvKj2uM7IiQ0VVLyQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pki0BoWL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pki0BoWL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 063FAC4CEEB;
	Tue, 16 Sep 2025 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758038244;
	bh=f3TpM0q/jbGHwcep8aGvrDILBW4ci9MLRRWsq0hf+Jc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pki0BoWLW1nr+DHOuqdkOPLNq+7i0CHL1o8UeNLkPcYHt82MJsKYF20WU2rKgPFew
	 /bQelS347cNq4/cc39yvb0I7TvnK8Wgx9OL5zRKOwJlqrtYaGtvFbhdMdwtgaxKOX4
	 CMN3th4di90JmfZJwqH9+9NRy9TfCm0yFzxRcdpEhPJxwwyNLLJ/s/xZcGmZa5IkG/
	 Zlux+8DgYzBcOGyW1rzJRuyRkXbuPKpjuUI37fThej31jj1t4acoAtme9IIAVgqKjo
	 /zgNM20HUuQIFGIE9HsjmGJiKpilvqO7jHnPb/peQVUokemRRTSmNk/+HXKgTm/Q6a
	 qI/6YFN+VjyNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE98CAC592;
	Tue, 16 Sep 2025 15:57:23 +0000 (UTC)
From: Arturs Artamonovs via B4 Relay <devnull+Arturs.Artamonovs.analog.com@kernel.org>
Date: Tue, 16 Sep 2025 16:57:17 +0100
Subject: [PATCH] tty: serial: fix help message for SERIAL_CPM
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-tty-serial-kconfig-fix-v1-1-f603824e494a@analog.com>
X-B4-Tracking: v=1; b=H4sIANyIyWgC/x2MQQqAIBAAvxJ7bkGXJOor0UF0q6Ww0Igi+nvWc
 QZmbkgchRO0xQ2RD0myhgy6LMBNNoyM4jMDKTKq0Qb3/cKvsQvObg2DjDjIiVVtjSLfKKsJcrx
 Fzvofd/3zvAvBfoJoAAAA
X-Change-ID: 20250915-tty-serial-kconfig-fix-47a502d90a12
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Arturs Artamonovs <Arturs.Artamonovs@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758038243; l=1155;
 i=Arturs.Artamonovs@analog.com; s=20240910; h=from:subject:message-id;
 bh=yjMgUPZ9DVsVDd5Qs/QLwakOMWYigatGAbBXRitE/vs=;
 b=kAiOk5rg5tzci+cACspD0J4h1CKJQrhFLIiuBO3TT7JXCAoMBeX2SmwGDbZpRwXcb53i+6sRk
 qxS1DrUMssMBYLQm2MhDXhCJo2Ph6lV+jGsnWOWAxURVmCeuWTIwQNu
X-Developer-Key: i=Arturs.Artamonovs@analog.com; a=ed25519;
 pk=UXODIid/MrmBXvqkX4PeEfetDaNAw9xKMINHIc5oZCk=
X-Endpoint-Received: by B4 Relay for Arturs.Artamonovs@analog.com/20240910
 with auth_id=327
X-Original-From: Arturs Artamonovs <Arturs.Artamonovs@analog.com>
Reply-To: Arturs.Artamonovs@analog.com

From: Arturs Artamonovs <Arturs.Artamonovs@analog.com>

Running checkpatch reported error extra whitespace at the
end of help message for SERIAL_CPM menu entry

Signed-off-by: Arturs Artamonovs <Arturs.Artamonovs@analog.com>
---
Running checkpath.pl on drivers/tty/serial reports error
Removing white space at the end of the line in Kconfig for SERIAL_CPM entry
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 44427415a80d7da63a8f2328b1932bff48500974..ac690f5cfbfe870a0c7eed4dc974d6ec28bb2c5f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -782,7 +782,7 @@ config SERIAL_CPM
 	depends on CPM2 || CPM1
 	select SERIAL_CORE
 	help
-	  This driver supports the SCC and SMC serial ports on Motorola 
+	  This driver supports the SCC and SMC serial ports on Motorola
 	  embedded PowerPC that contain a CPM1 (8xx) or CPM2 (8xxx)
 
 config SERIAL_CPM_CONSOLE

---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250915-tty-serial-kconfig-fix-47a502d90a12

Best regards,
-- 
Arturs Artamonovs <Arturs.Artamonovs@analog.com>


