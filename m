Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F915E5C2;
	Mon, 17 Mar 2025 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194850; cv=none; b=LK6o8XFY7g2l6YelOVEXRXj4fcXxRXuN0Jh2CAk6n963cQ4a6nuXDMeR4c1KnWJ4GHYQJA0J4rwHBB2xu1M0jNtMPum4za1YdX+jnYH4+B1uz3Xud8XSXmKSNoFSQBDJTMacE/+YdhSMfYqxBgts6SlTLqtchdg2Ur0GRwQZhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194850; c=relaxed/simple;
	bh=3xlgiwnCx9ACqoF762hkPvtcJJShUF6Q9QE5Xiop/BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HgIFmzydZvLRmQJBfoRMDzZqQJUCDoD/OrFSgOBLk6HXpKX4JSN4G3ygM5u3tJkrxQHj0S6MmnVdWeb+q16lhQY4h9nP6vRZhtjmcbQiwUbRYeL13lnJApGbj3cjSkgBRv63gnXoB9b1WHT1wAx1ew2RYHDEATuQswT9tGeF1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruVum5IF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruVum5IF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE0FC4CEE3;
	Mon, 17 Mar 2025 07:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194849;
	bh=3xlgiwnCx9ACqoF762hkPvtcJJShUF6Q9QE5Xiop/BA=;
	h=From:To:Cc:Subject:Date:From;
	b=ruVum5IFQsLcoPcsC+Tf2/lLCMEwjDxCzLvalVqmJ29KImQKd9VQcT+DUPhylQtG8
	 bIlBaEWUi8digtTuWRyNLRC1cMSQ+mm0Nsm++O0eMdJfsmidlt2931CrCtbF6/gyL5
	 1Y0UEj6VL91gzW184aODCmCWqJtpfPhtQwgd2jQXwhKJXDLeXIPVWn7oSdzF+RL4AI
	 fj5+rEkZkI07H7eELkOaDje3VWiELHpwJtuo+6jMYAF573GkI/lKfRloKz77zykeVg
	 28MGg8SyhLx5xIpvrh3sMxhyyBLRj5M0JJnzU0OF8Mq5AO2JxIA5cC+96cVURiKCpU
	 IG+h2o4eF8yFQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 00/31] tty: cleanup no. 99
Date: Mon, 17 Mar 2025 08:00:15 +0100
Message-ID: <20250317070046.24386-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

this is (again) a series of cleanup in tty. I am trying to rework
tty+serial to avoid limitations of devices (so called NR_UART or
tty_alloc_driver()'s first parameter). And the below popped up while
crawling through the code. So this is only a prep cleanup.

* many tty flags are now enums
* many functions were improved for readability
* quite a few unused or old code dropped

In particular, the runtime behaviour of the kernel before and after the
changes is supposed to be bug to bug compatible (except moxa's ioctl
and ISA evils dropped). That is, noone should notice.

[v2]
 * use serial_port_in/out() helpers in 26/30 (and not use serial_in/out())
 * the last patch is new

Jiri Slaby (SUSE) (31):
  tty: convert "TTY Struct Flags" to an enum
  tty: audit: do not use N_TTY_BUF_SIZE
  tty: caif: do not use N_TTY_BUF_SIZE
  tty: move N_TTY_BUF_SIZE to n_tty
  tty: n_tty: use uint for space returned by tty_write_room()
  tty: n_tty: simplify process_output()
  tty: n_tty: clean up process_output_block()
  tty: n_tty: drop n_tty_trace()
  tty: n_tty: extract n_tty_continue_cookie() from n_tty_read()
  tty: n_tty: extract n_tty_wait_for_input()
  tty: n_tty: move more_to_be_read to the end of n_tty_read()
  tty: tty_driver: move TTY macros to the top
  tty: tty_driver: convert "TTY Driver Flags" to an enum
  tty: tty_driver: document both {,__}tty_alloc_driver() properly
  tty: tty_driver: introduce TTY driver sub/types enums
  tty: serdev: drop serdev_controller_ops::write_room()
  tty: mmc: sdio: use bool for cts and remove parentheses
  tty: moxa: drop version dump to logs
  tty: moxa: drop ISA support
  tty: moxa: carve out special ioctls and extra tty_port
  tty: srmcons: fix retval from srmcons_init()
  tty: staging/greybus: pass tty_driver flags to tty_alloc_driver()
  tty: sunsu: drop serial_{in,out}p()
  tty: sunsu: remove unused serial_icr_read()
  serial: remove redundant tty_port_link_device()
  serial: pass struct uart_state to uart_line_info()
  serial: 8250: use serial_port_in/out() helpers
  serial: 8250_rsa: simplify rsa8250_{request/release}_resource()
  serial: 8250_port: do not use goto for UPQ_NO_TXEN_TEST code flow
  serial: 8250_port: simplify serial8250_request_std_resource()
  serial: switch change_irq and change_port to bool in uart_set_info()

 Documentation/driver-api/tty/tty_driver.rst |   4 +-
 Documentation/driver-api/tty/tty_struct.rst |   2 +-
 arch/alpha/kernel/srmcons.c                 |  62 ++---
 drivers/mmc/core/sdio_uart.c                |   2 +-
 drivers/net/caif/caif_serial.c              |   2 +-
 drivers/staging/greybus/uart.c              |   4 +-
 drivers/tty/Kconfig                         |   2 +-
 drivers/tty/moxa.c                          | 251 +-------------------
 drivers/tty/n_tty.c                         | 212 ++++++++---------
 drivers/tty/serdev/core.c                   |  11 -
 drivers/tty/serdev/serdev-ttyport.c         |   9 -
 drivers/tty/serial/8250/8250_dw.c           |  16 +-
 drivers/tty/serial/8250/8250_fsl.c          |   8 +-
 drivers/tty/serial/8250/8250_omap.c         |   2 +-
 drivers/tty/serial/8250/8250_port.c         |  59 ++---
 drivers/tty/serial/8250/8250_rsa.c          |  21 +-
 drivers/tty/serial/serial_core.c            |  10 +-
 drivers/tty/serial/sunsu.c                  | 178 ++++++--------
 drivers/tty/tty_audit.c                     |  10 +-
 drivers/tty/tty_io.c                        |   8 +-
 include/linux/serdev.h                      |   6 -
 include/linux/tty.h                         |  53 +++--
 include/linux/tty_driver.h                  | 180 +++++++-------
 23 files changed, 412 insertions(+), 700 deletions(-)

-- 
2.49.0

