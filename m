From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/9] Blackfin Serial Driver: updates kgdb over Blackfin
 serial driver with kgdb framework
Date: Fri, 17 Oct 2008 18:41:55 +0100
Message-ID: <20081017184155.4143a88a@lxorguk.ukuu.org.uk>
References: <1224179047-13073-1-git-send-email-cooloney@kernel.org>
	<1224179047-13073-2-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60914 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754701AbYJQRmR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Oct 2008 13:42:17 -0400
In-Reply-To: <1224179047-13073-2-git-send-email-cooloney@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <cooloney@kernel.org>

The previous set are already merged/reviewed in the ttydev tree (barring
the cpu_relax mystery item) so I'd much rather get patches versus the
ttydev tree so I can see what has actually changed this time not
re-review the entire collection again.

Alan
