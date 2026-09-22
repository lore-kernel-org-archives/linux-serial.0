Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385173630AE;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040440; cv=none; b=mrXjFoe+g6eWXU7KN3cuY7f//1bzQTFyDgygkjOvQY0yLbuQ0SkgiHwnIbglHxe68HMKkrj7+4niTCGCLbSi2P7J87cJ49C2HjNA2Zkk/nmr+RpjCPX2huU0yT2iEZrN69nzvZoDeSqoiRJAfxQJhbHRjzetsBE6u/GEPn+p49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040440; c=relaxed/simple;
	bh=UG7lewV4+pwaB/tgYoBoUkEr0r3d/oFPFXqtv5DLQAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WzxOgCNye8Hvl84MPr4Nk+Z9FcpbB7N6B0X/ZgHmE7vQ5y222i6Od3CVXdCSf6XEqfThLlTKjm0Q3b4XQvlRhaFRpZ30pg78SDSkTutSAYnzyggQ7l0H9EJus0jpD9Xp6jPN52oBOxFBlVQFfkGPVm1PD84MFt0zQFYM2QbK8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO6aIvIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO6aIvIk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C50FAC2BCB3;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790040439;
	bh=UG7lewV4+pwaB/tgYoBoUkEr0r3d/oFPFXqtv5DLQAA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lO6aIvIkZitspCBAB7BK6yBzKHGbKy9cOdtdKC/cYwkW1jlzMqP0Zu0Yq5/egCgQV
	 GH9N/W1n/nnqNVQjkR+OHCq6oH6l2pyNZeD8lglMPre+dhpIk/uzPYFiEkVabs4dSF
	 0gJdoS3ntr7xOhYxU+I572v7xOxnfc0aKW0J/UgNX+ipkaq+kcvDCHZPQ1qGUPB3J7
	 o0u3Azut8WNVyV/pYPMXrjp255fKy21EQwgRnZg8n3YsavLkuGCxfr7b6rqX6xxXb8
	 BHFDhzDEfe6w8CA7ZVhPNql2dG2SFDU+wWjtcmoPEpR5gZprVtdgFfnAgzEhu6aOLu
	 Qrtwye1pxJUgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A4C982FD;
	Tue, 22 Sep 2026 01:27:19 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Subject: [PATCH 0/3] vt: make the console_lock ordering explicit for three
 variables
Date: Mon, 21 Sep 2026 21:27:13 -0400
Message-Id: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHZsWoC/yXMzQrCMBAE4Fcpe3Zlkxb/XqV4SOLGRjDKbg1C6
 bub1OM3zMwCypJY4dItIFySpleuMLsOwuTynTHdqsGSPdDZGnx6LDMGRxSHE/UmEtTuWzim7/Y
 zXv/Wj39wmNu4NbxTRi8uh6lFG8tx36OEAdb1B1pDSXeJAAAA
X-Change-ID: 20260921-mb-vt-ca00f48031f0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790040439; l=1173;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=UG7lewV4+pwaB/tgYoBoUkEr0r3d/oFPFXqtv5DLQAA=;
 b=2U6L/bpo7bgH3CClVIi1J5FFquCjjlkI8E2ECOcBJ+J4KRGCDgBz5WBbTg4EpzNp9dvW4fcon
 5py/Y42tw/tBQfLRI8W3SXovgjVMpK/5UQ0gFjQRlpXOWyHsL4fELuJ
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

Three variables in vt.c are written on one path and read on another with
plain accesses on both sides: fg_console between redraw_screen() and
vt_console_print(), console_blanked between do_blank_screen() and
do_unblank_screen(), and the vc_cons[] slot between vc_deallocate() and
console_callback().

Every one of these pairs is serialised by console_lock today, so no behaviour
changes. The patches state the publication order in the accessors rather than
leaving it implicit in the lock, so the dependency is visible where the
variables are used.

Found with MBCheck, a static herd7-based memory consistency checker.
Compile-tested on arm64 with W=1, no new warnings.

---
Jaidev Shastri (3):
      vt: order the fg_console switch against vt_console_print()
      vt: order console_blanked between blanking and unblanking
      vt: order the vc_cons[] clear against console_callback()

 drivers/tty/vt/vt.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-vt-ca00f48031f0

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


