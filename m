From: rich+ml@lclogic.com
Subject: Re: tcdrain / TCSBRK / wait_until_sent delay
Date: Thu, 5 May 2005 10:51:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505051023210.21399@deadrat.localdomain>
References: <200505051650.38471.andyparkins@gmail.com>
Reply-To: rich+ml@lclogic.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-64-164-130-3.dsl.snfc21.pacbell.net ([64.164.130.3]:60147
	"EHLO deadrat.localdomain") by vger.kernel.org with ESMTP
	id S261298AbVEERvx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 May 2005 13:51:53 -0400
In-Reply-To: <200505051650.38471.andyparkins@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
Cc: linux-serial@vger.kernel.org

On Thu, 5 May 2005, Andy Parkins wrote:

> Is it unreasonable to expect Linux to do a 200us turnaround?

Assuming you have 2.6 kernel? HZ=1000 and you'll only get 1mS resolution

== Rich
