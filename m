From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] serial: bfin_sport_uart: Use resource size to fix
	off-by-one error
Date: Tue, 11 May 2010 14:08:54 -0400
Message-ID: <AANLkTilzQO2a6OZFctMwEXiywCIlrfRfWyC4MyDQ4JJE@mail.gmail.com>
References: <1273561823-4495-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47818 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756984Ab0EKSJQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 May 2010 14:09:16 -0400
In-Reply-To: <1273561823-4495-1-git-send-email-tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: gregkh@suse.de, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org

On Tue, May 11, 2010 at 03:10, Tobias Klauser wrote:
> Use the resource_size function instead of manually calculating the
> resource size. This actually fixes an off-by-one error.

thanks !

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
-mike
