From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/4] tty: serial: altera_uart: Handle pdev->id == -1 in
 altera_uart_remove
Date: Wed, 9 Feb 2011 13:46:14 +0300
Message-ID: <20110209104614.GA21588@oksana.dev.rtsoft.ru>
References: <cover.1297245277.git.tklauser@distanz.ch>
 <9212990ebdb34f2b80d6858a9ba2a88b4d53a207.1297245277.git.tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52172 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab1BIKqU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Feb 2011 05:46:20 -0500
Content-Disposition: inline
In-Reply-To: <9212990ebdb34f2b80d6858a9ba2a88b4d53a207.1297245277.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-kernel@vger.kernel.org

On Wed, Feb 09, 2011 at 10:56:52AM +0100, Tobias Klauser wrote:
> Commit 6b5756f176568a710d008d3b478128fafb6707f0 introduced the
> possibility for pdev->id being -1 but the change was not done equally in
> altera_uart_remove. This patch fixes this.
> 
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
