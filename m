Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD362D660E;
	Fri, 30 Jan 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779755; cv=none; b=sggSzOIVSSzUQfZKQfGowp3ll2JfKCj75wBFVGasw8YTH4ElGRtMWFDwybVqUipCbssENHqPT7T1wIyMGg7l67aJRFtfQEdk6NF3+oi0Nbn2Mrm7BBdu7ZFaOFdjFtrSP6lKiRdb/og27chUIBpL1PsE959zx4KJclD5CZTlsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779755; c=relaxed/simple;
	bh=DJY8jeEMA2g8yvKK4+pNIYfktXTywqa+cWfcCcfsGGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XqjaSLpDlnZWh/plIz5LAjYb5Sjlwbciag21Vs+WxhOsnY7I9aSUKld8XBPQWIaewFPn9kZlKWGsDd4PNqqUppcDOFpKD5c9AD+LyKEEgLHGWVpXKat8YFPdQjfpoaTQoCED77AWMHghps+nbfQA7rfF4PJDiGKhyzoc2iHfaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9NW7O9Q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9NW7O9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769779754; x=1801315754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DJY8jeEMA2g8yvKK4+pNIYfktXTywqa+cWfcCcfsGGk=;
  b=b9NW7O9Qz2UZMzB9XreRTaWPUXCFLt6jwB5ywdB74hz9ZtG/x4UHplc0
   pPiJEaYUGxt6kJGNnTv7DTSmo28PLudfbvmGWJlwgbfnK1CaFJMqNzY2Q
   woHbkEofK+9rbfBpKUtYdvRUjANB3o9maZTxUaZK3fd0jwUmw1cHK+Ekp
   Yce+MwZ83fOMKJFd0fBfxos4KLA+39sXJ9qaa4LgL3vnhMj2nlVvZuT30
   qTAhAVtnNfWqxbIUOUVLnmi964oKmDk1AsDM9LhRjEPiW0jYjNKx4JxjU
   ljqAyZNsN2YLfp49BdKtC4GAz0MpVKqB6D4FQvmubBkhTiZyho5PxpeIB
   g==;
X-CSE-ConnectionGUID: rBDAbvLbS3eIcklA3YIbZA==
X-CSE-MsgGUID: pr7D0E6hTAaYjT+1EF/7Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74882358"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="74882358"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 05:29:13 -0800
X-CSE-ConnectionGUID: 1WONRTJDRNuKJ03x5/4mXQ==
X-CSE-MsgGUID: abyZmnEfSou5rQdmpvQnmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="209103775"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 05:29:09 -0800
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
Subject: [PATCH v3 0/7] 8250 DW UART fixes when under constant Rx pressure
Date: Fri, 30 Jan 2026 15:28:50 +0200
Message-Id: <20260130132857.13124-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/8250/8250_dw.c   | 295 ++++++++++++++++++++++------
 drivers/tty/serial/8250/8250_port.c |  69 ++++---
 include/linux/serial_8250.h         |   1 +
 4 files changed, 303 insertions(+), 87 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.39.5

