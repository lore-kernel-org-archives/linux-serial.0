From: Antti Palosaari <crope@iki.fi>
Subject: serial device name for smart card reader that is integrated to Anysee
 DVB USB device
Date: Wed, 05 Oct 2011 00:22:09 +0300
Message-ID: <4E8B7901.2050700@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-media@vger.kernel.org, linux-usb@vger.kernel.org
Cc: =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, James Courtier-Dutton <james.dutton@gmail.com>, HoP <jpetrous@gmail.com>, =?ISO-8859-1?Q?Istv=E1n_V=E1radi?= <ivaradi@gmail.com>
List-Id: linux-serial@vger.kernel.org

I have been looking for correct device name for serial smart card reader 
that is integrated to Anysee DVB USB devices. Consider it like old so 
called Phoenix reader. Phoenix is de facto protocol used for such 
readers and there is whole bunch of different RS232 (/dev/ttyS#) or 
USB-serial (/dev/ttyUSB#) readers using that protocol.

Anyhow, that one is integrated to DVB USB device that is driven by 
dvb_usb_anysee driver. As I understand, I need reserve new device name 
and major number for my device. See Documentation/devices.txt

Current proof-of-concept driver can be found from:
http://git.linuxtv.org/anttip/media_tree.git/shortlog/refs/heads/anysee-sc
Don't review code since it is not ready for release yet, it even lacks 
locking.

There have been some proposes about names, mainly whether to register it 
under the DVB adapter it is physically (/dev/dvb/adapterN/sc#) or to the 
root of /dev (/dev/sc#). I used sc as name, SC=SmartCard.

Could someone who have enough knowledge point out which one is correct 
or better?


regards
Antti

-- 
http://palosaari.fi/
