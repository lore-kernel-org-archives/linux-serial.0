From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 0/2] staging: dgrp: remove use of real_raw and read_cnt
Date: Thu, 25 Oct 2012 12:46:20 -0400
Message-ID: <1351183582-13573-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:43287 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759958Ab2JYQqe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2012 12:46:34 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org


Patches for tty-next to fix dgrp breakage when real_raw and and
read_cnt where removed from tty_struct.

-- 
Bill



