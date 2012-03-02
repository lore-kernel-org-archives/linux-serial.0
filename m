From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 5/7] serial: remove back and forth conversions in
 serial_out_sync
Date: Fri, 2 Mar 2012 11:22:04 +0000
Message-ID: <20120302112204.4f990c78@bob.linux.org.uk>
References: <1330655603-5268-1-git-send-email-paul.gortmaker@windriver.com>
	<1330655603-5268-6-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4268 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756007Ab2CBLHp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Mar 2012 06:07:45 -0500
In-Reply-To: <1330655603-5268-6-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

On Thu,  1 Mar 2012 21:33:21 -0500
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> The two callers to serial_out_sync() have a struct port right
> there in scope, but then pass in a struct 8250_port which then
> is locally resolved to a struct port.

This change I don't like. It means serial_out_sync and serial_out end
up with different parameters which seems odd to say the least. You then
extend this oddity by adding helpers for port_in/out but not the sync
one.

Otherwise it all looks good to me.

Alan


