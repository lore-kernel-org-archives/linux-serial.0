From: Ilya Zykov <linux@izyk.ru>
Subject: Re: [PATCH 03/18] tty: Simplify tty buffer/ldisc interface with helper
 function
Date: Wed, 20 Mar 2013 23:25:28 +0400
Message-ID: <514A0D28.4060804@izyk.ru>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>   <1363724513-15604-4-git-send-email-peter@hurleysoftware.com>   <5148E9D2.4030305@izyk.ru> <1363737036.3413.49.camel@thor.lan>  <5149AFD0.8020604@izyk.ru> <1363801796.4280.24.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:53713 "EHLO
	mail.izyk.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab3CTTZc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Mar 2013 15:25:32 -0400
In-Reply-To: <1363801796.4280.24.camel@thor.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Min Zhang <mzhang@mvista.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 20.03.2013 21:49, Peter Hurley wrote:
> The motivation for changing the workqueue api to allow parallel work
> items on SMP was to fix a class of deadlocks where forward progress
> could not be made due to subtle dependencies between work items
> (actually that potential still exists with self-modifying work-items,
> ie., work items that change their function).
> 
> The tty layer would need a detailed and thorough analysis of potential
> dependencies to avoid creating problems. The drivers that use work items
> might need examination as well.

Sorry, but I don't understand.
My knowledge is very weak.

We say about three works:
hangup_work, SAK_work, buf.work
or anything else?

