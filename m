From: Andrew Morton <akpm@osdl.org>
Subject: Re: new device driver to enable the IBM Multiport Serial Adapter in
 Linux
Date: Tue, 27 Jul 2004 00:03:59 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040727000359.6e0af2e0.akpm@osdl.org>
References: <41055722.2070104@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:3210 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266287AbUG0HFZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jul 2004 03:05:25 -0400
In-Reply-To: <41055722.2070104@us.ibm.com>
List-Id: linux-serial@vger.kernel.org
To: Janice M Girouard <janiceg@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, wenxiong@us.ibm.com, linux-serial@vger.kernel.org

Janice M Girouard <janiceg@us.ibm.com> wrote:
>
> The patch below enables the IBM Multiport Serial Adapter for the Linux 
>  OS.

Looks sane.  Did you really intend that it be buildable for all
architectures?  (There's nothing wrong with this - it's good.  But it's a
bit unusual for this sort of driver).

"IBM multiport serial adapter" seems to be a rather generic description of
this device.  Is this the only multiport serial adapter which IBM has ever,
or will ever make?  If not, then perhaps we could make the description a
little more specific?

