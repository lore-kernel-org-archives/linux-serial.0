From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Subject: TTY_FLIPBUF_SIZE
Date: Tue, 17 Dec 2002 17:13:59 +0530
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3DFF0DFF.8030505@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello,

The TTY_FLIPBUF_SIZE is restricted to 2 * 512 bytes. Can this be 
increased to support synchronous serial lines without affecting other 
serial drivers which still stick to the TTY_FLIPBUF_SIZE limit ?

Thank you.

Regards,
Sriram

