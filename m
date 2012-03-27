From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] amba-pl011: fix panic introduced by "clear pending interrupts"
Date: Tue, 27 Mar 2012 16:12:05 +0400
Message-ID: <4F71AE95.9080600@mvista.com>
References: <20120326203209.GA8182@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62042 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab2C0MNe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Mar 2012 08:13:34 -0400
Received: by bkcik5 with SMTP id ik5so4814520bkc.19
        for <linux-serial@vger.kernel.org>; Tue, 27 Mar 2012 05:13:33 -0700 (PDT)
In-Reply-To: <20120326203209.GA8182@mail.gnudd.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alessandro Rubini <rubini@gnudd.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

Hello.

On 27-03-2012 0:32, Alessandro Rubini wrote:

> patch 9b96fba, currently in linux-next, clears interrupts using

    Please also specify the summary of this commit in parens.

> uap->port.membase that has not been assigned.  My x86 system,
> that uses a pci-to-amba bridge, panics with a message like:

>     BUG: unable to handle kernel NULL pointer dereference at 00000038
>     IP: [<c12c85ed>] pl011_probe+0x119/0x303

> Signed-off-by: Alessandro Rubini<rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi<giancarlo.asnaghi@st.com>

WBR, Sergei
