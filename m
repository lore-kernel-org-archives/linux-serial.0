From: "Eble, Dan" <DanE@aiinet.com>
Subject: RE: Hdlc, Wan, and the like
Date: Mon, 24 Nov 2003 09:25:39 -0500
Sender: linux-net-owner@vger.kernel.org
Message-ID: <AD59566A9D83864F871AE2E52503064001663C6E@aimail.aiinet.priv>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-net-owner@vger.kernel.org>
To: 'Dale Whitchurch' <DaleW@sealevel.com>
Cc: Linux Net <linux-net@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> 1) Is there a reason to maintain these cards as network devices and
> _not_ develop them as character devices as well?

Sure.  It's half the work.  (right?)

> 2) Are there drivers or utilities already created that provide a
> user-/kernel- level translation between a character device 
> and a network device?

There is a layer that adapts async/sync tty to the generic PPP layer, but
the generic HDLC layer can speak to generic PPP as well, with a few
modifications.  I'm not familiar with the kernel implementation of any other
protocols.

[BTW, has anyone had any contact with Krysztof Halasa, the generic HDLC
maintainer, lately?  He stopped answering email several months ago.]
