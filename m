From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: TTY_FLIPBUF_SIZE
Date: Tue, 17 Dec 2002 11:13:18 -0500
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <013001c2a5e7$366df740$294b82ce@connecttech.com>
References: <3DFF0DFF.8030505@tataelxsi.co.in>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: Sriram Narasimhan <nsri@tataelxsi.co.in>, linux-serial@vger.kernel.org

From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
> The TTY_FLIPBUF_SIZE is restricted to 2 * 512 bytes. Can this be
> increased to support synchronous serial lines without affecting other
> serial drivers which still stick to the TTY_FLIPBUF_SIZE limit ?

No. Check the code. struct tty_struct depends on being less than one
page (4 kb) in size, and making the flip bufs any much bigger will
break that.

..Stu


