From: Josh Hansen <doctorj@softhome.net>
Subject: Siemens SX56 ipaq.o adaptation?
Date: Mon, 31 Mar 2003 17:58:43 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <3E88F253.9070106@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I just bought the Siemens SX56 PocketPC/Phone from AT&T wireless. I am 
looking into what it will take to sync this PDA with my Linux system, 
and I think the key thing preventing me from doing that is that the 
kernel, after recognizing that the SX56 is connected to the USB, doesn't 
have a driver that claims the device. The ipaq module I would think 
could recognize the device and facilitate serial communications with it, 
which is where userspace programs take over.

Anyway, my question is how big of a deal would it be to get driver 
support for this PDA?

- Josh Hansen

