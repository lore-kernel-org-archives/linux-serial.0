Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD430E84F;
	Tue,  3 Feb 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138674; cv=none; b=EzW2tLM38WLAiNAaStuDXd+iUdCVl8N3V7tjxgfJbB9tny7I/zkFvbjwnLyWZkelO1kXDAkfx0vgN4r38zgPlssmTInCSJny0L8d6vHf+gWnL/80TRVYxObsIHsaELtR/vsRGjHfr4Vs4Xb9a+fwepjKHyai1WfHkxsV8n1GU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138674; c=relaxed/simple;
	bh=8ixO+nqOzG9WZY1jc1c9FLC+F9j7uIRdcsZx7vpY6So=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qL9wMIU4P1t6J3GgINViCeetgq5czkXLKAqv2k/r72mRf60YW1hLfc8LUI17ZxRHbw2b0bPgKaFKpEY84sV/emSYxZCrN8QwiZ1kn3B8HxbwWZjb5dkGEmYmINoZxx6yp4MrW7/l3Xukasqox6vYBeUpw2jToXlG4UrBl8uH/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfraltpx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfraltpx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770138673; x=1801674673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8ixO+nqOzG9WZY1jc1c9FLC+F9j7uIRdcsZx7vpY6So=;
  b=bfraltpxFrhRnvz6mAhr2w8UxP0atT2XT4HkQPszA4H2c7mriV+7xKmJ
   ehjJYwWtMS8F1gLufAE6u+v9qdqtQ0RC12Ydt4MIcdIrLRK2izSpvsTyQ
   W97i3bt5P77YLBWtwoMd85eOPa331bCnYPPovimeX/UcnDCMt8JCG7lDm
   +q2SoQvcPHXT6hO/oAyNM+Ikb2hTFuJ7HCep71XDDtg+CQiNRtYCCkpeA
   Rpu8Ut9RB7EKojI2DCekLg+aDSvTLLLYrKKrGrFP26apzaXdtbxMiVAWQ
   jC9RpjckS8cp5kJliKFM0m9AeEgVvwVBtnH2xJeQh/IzzhD8aDnvwaJ1K
   w==;
X-CSE-ConnectionGUID: uUZ7j9ssTqmuVOqwIgvtDQ==
X-CSE-MsgGUID: GL2PFL+4Raery6/iDbqe9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71220766"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71220766"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:12 -0800
X-CSE-ConnectionGUID: ZNfFgVZcS46DqM8fG7kI8w==
X-CSE-MsgGUID: 8Foy5zknRG+v+x88eVe2iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="240589421"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:10:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>
Cc: linux-kernel@vger.kernel.org,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/7] 8250 DW UART fixes when under constant Rx pressure
Date: Tue,  3 Feb 2026 19:10:42 +0200
Message-Id: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here are fixes to 8250 DW UART conditions that mostly occur in scenarios
under constant Rx pressure which are made complicated by BUSY handling
of DW UARTs (used when !uart_16550_compatible).

A few of the changes touch also 8250_port but it's mostly moving existing
code around (except for the extra synchronize_irq() in shutdown).

Pending cleanups (to be sent separately):
 - 8250_dw: UART_IIR_RX_TIMEOUT move to switch/case 
 - 8250: include sorting
 - 8250: iir types to u8

v4:
- Fix warning about label at the end (due to commented out code) being
  an extension by adding an otherwise unnecessary return.

v3:
- Rollback dw8250_idle_enter() failures within
- usr_reg = ... ? ... : ...;
- Leave LCR write fail dev_err() where it was (commented out)

v2:
- Added Fixes tags pointing DW & INTC10EE introducing commits
- Added Cc stable to prerequisite patches
- Separate adding serial8250_handle_irq_locked() to own patch
- Put new exports to SERIAL_8250 namespace (eventually all 8250
  exports should move there, but out-of-scope for this series)
- Changes to no_int_count
	- Change type to u8
	- Use modulo in increment, add a define for it
	- Perform kick only on 4th NO_INT
- Use serial_port_in/out() throughout the series
- Add FIXME comments to ndelay(frame_time) about very low baud rates
- Add cleanup.h
- Tweak lockdep.h place among misordered includes
- Wording tweaks to changelogs and comments

Ilpo Järvinen (7):
  serial: 8250: Protect LCR write in shutdown
  serial: 8250_dw: Avoid unnecessary LCR writes
  serial: 8250: Add serial8250_handle_irq_locked()
  serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
  serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
  serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART
    BUSY
  serial: 8250_dw: Ensure BUSY is deasserted

 drivers/tty/serial/8250/8250.h      |  25 +++
 drivers/tty/serial/8250/8250_dw.c   | 296 ++++++++++++++++++++++------
 drivers/tty/serial/8250/8250_port.c |  69 ++++---
 include/linux/serial_8250.h         |   1 +
 4 files changed, 304 insertions(+), 87 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.39.5

