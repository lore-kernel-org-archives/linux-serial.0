Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB21946DA;
	Wed,  6 May 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071455; cv=none; b=UdyDDeYNSVRh+2DhmEPFE+4q+V3lxISgsL7m0HVJZiH0DtVmsptkuq7oVHSGGkXl1PpXBEX/x47jZ3d5SrK6gVkk0SOFOXRTJsE3K5rY1UdHi+BUP30Xl24ibHAu7cWwryaV6xUJ5gI0FdwAl1Hc2UfsQW0cMhnU6zBb5NPffmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071455; c=relaxed/simple;
	bh=1MIWh7K4TBKVnNnQ+Vy1NeHUsNEugMX8VmUJ+QhSJbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvhGNp0I8cmUQA0A4+k45/p+tcRaUqOwovS9D4wH2janf9rGn+fQmoX3ZirbVfDSjRaU/Glb4ih4S4LNYNPFXp7/HZC+ZExpGy28vwWTaDIripMXzWbDNJEOVV95xEj3zilmhXMVAbMV/xO660fd8r0fCzjAlzUwhrU2cOsGFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFA125bM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFA125bM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E194C2BCB8;
	Wed,  6 May 2026 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778071454;
	bh=1MIWh7K4TBKVnNnQ+Vy1NeHUsNEugMX8VmUJ+QhSJbI=;
	h=From:To:Cc:Subject:Date:From;
	b=iFA125bMzzqjj7nvfP96YmVYwk/Hyp7w/HxzC4ZVbswEJ2tRpEOR8uyqvKX86/tS3
	 /nc4uBc8m0I/uniFL5h7Hz6Km+oZkBNLbhtuO/IGb5ocxVQZc0sICDv2NAG+65U/QP
	 B/4KgvXVtuC8nHuBTIHrOPQtzczPSHZEJAvVDlY6SAhDiJ8KZhz7VEbZ4EoDtmXlAW
	 uDL7vUM2qM6HtUv4db+tKQd4A5DuJLqUxjCPt6vGzkSx2Rq3OIDjK4kjJfvLYRbx2M
	 TLfNCLWFrMDohP31BeMqTZ890GKK3LNZWBg3uu3C2fsQcxvvDbzkpV+G8PoC/jc/L8
	 7c/xpEksJ6pFA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKbbo-00000000nJJ-09nE;
	Wed, 06 May 2026 14:44:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] tty: add missing tty_driver include to tty_port.h
Date: Wed,  6 May 2026 14:43:23 +0200
Message-ID: <20260506124323.186703-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the definition of struct tty_driver in tty_port.h to keep the
header self-contained and avoid build breakage in case anyone includes
it before tty_driver.h.

Fixes: eb3b0d92c9c3 ("tty: tty_port: add workqueue to flip TTY buffer")
Cc: Xin Zhao <jackzxcui1989@163.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

The offending commit went into 7.1-rc1 so this could go into tty-linus.

Johan


 include/linux/tty_port.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index d2a7882c0b58..23cad403bb8f 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -6,10 +6,10 @@
 #include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/tty_buffer.h>
+#include <linux/tty_driver.h>
 #include <linux/wait.h>
 
 struct attribute_group;
-struct tty_driver;
 struct tty_port;
 struct tty_struct;
 
-- 
2.53.0

