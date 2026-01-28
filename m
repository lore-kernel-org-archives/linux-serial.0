Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BB331A7E;
	Wed, 28 Jan 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597594; cv=none; b=l+PfvE7f0BzOsuES+3vU+DDG6kW+qKJXhGXyoKVeFSaS8VcJBmfpzraSlXd3z6gOuG2LyfQBvko7WiK/Ajp/CBCMUkld7trsjER7UctuN5+eAf27RfvmvSn6GV5ngyjgmR11d8CcYj948jBKawrgmrFU1tFL22CH9+4ZI1Xy69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597594; c=relaxed/simple;
	bh=/FkjHkx1esFcrGWS2v6HOpdOvnS0GlFCAc7PMUMlCBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I8IoI2rGr334p5h084ZDRPpnBajrgF19YJlrtywrmdAW7w/p1TH006QsUgLKiUMDpFLovSPsM2TcwEKIC10soVLhW1IS0+XM5ZtkBwbRr1mF/b+ubeomV7PpFQXe7dr/KjHpafaqKTUNZOb7cN1gs5hssDdMKR0RPCvhGDO/tbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NobReLzo; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NobReLzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769597593; x=1801133593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/FkjHkx1esFcrGWS2v6HOpdOvnS0GlFCAc7PMUMlCBs=;
  b=NobReLzofwxF6VaQcAC3SPhGdxsxlfOZ+yUCcprXX52X4oHrxjc5wVyi
   UiL7fWAHNFz7MbzR9uP1DkL1MNmXYKOrDq4JwZSKUqW5+hP5W1hrMRc/z
   rSFuu8efYGjnv80hY1E4fsiv5SrOoKcRyBVkLfsrufqfyHF0ZV8yd0H5K
   YaD9M898AkRJEDRgs5wwdzFRkp3D5DPzPej8qE/l3Kt19Qt8NiA1G4Cu8
   j81kGO2rqiWI8UlcE1EDOlEtrpnhAAYiFyuxj4Py5ngNmL4oc0QPP9IIK
   //nlc3Haup1Z88/olktoySLvkOcFKdErl/c1gaMH2vCqYG/6mU/TWQUEP
   Q==;
X-CSE-ConnectionGUID: HhVyEfOdQ7eS8FBfXggwxA==
X-CSE-MsgGUID: 0z2qUV78RaqmR0fDYwsl3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70848791"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70848791"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 02:53:12 -0800
X-CSE-ConnectionGUID: ovW0u+ECQoufSNpx8KZjwg==
X-CSE-MsgGUID: u5DU4QxtQJmY5yvitTJLIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212787993"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.14])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 02:53:09 -0800
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
Subject: [PATCH v2 0/7] 8250 DW UART fixes when under constant Rx pressure
Date: Wed, 28 Jan 2026 12:52:54 +0200
Message-Id: <20260128105301.1869-1-ilpo.jarvinen@linux.intel.com>
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

I'll do UART_IIR_RX_TIMEOUT move to switch/case separately from this
fix series and a few other cleanups Andy brought up.


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
 drivers/tty/serial/8250/8250_dw.c   | 309 ++++++++++++++++++++++------
 drivers/tty/serial/8250/8250_port.c |  69 ++++---
 include/linux/serial_8250.h         |   1 +
 4 files changed, 313 insertions(+), 91 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.39.5

