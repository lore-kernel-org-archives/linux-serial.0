From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 21/26] tty: Convert tty_struct bitfield to bools
Date: Wed, 03 Sep 2014 08:14:59 -0400
Message-ID: <54070643.9080903@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>	<1409693975-1028-22-git-send-email-peter@hurleysoftware.com> <20140903115852.5a720754@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:48254 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755924AbaICMPJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Sep 2014 08:15:09 -0400
In-Reply-To: <20140903115852.5a720754@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/03/2014 06:58 AM, One Thousand Gnomes wrote:
> On Tue,  2 Sep 2014 17:39:30 -0400
> Peter Hurley <peter@hurleysoftware.com> wrote:
> 
>> The stopped, hw_stopped, flow_stopped and packet bits are smp-unsafe
>> and interrupt-unsafe. For example,
>>
>> CPU 0                         | CPU 1
>>                               |
>> tty->flow_stopped = 1         | tty->hw_stopped = 0
>>
>> One of these updates will be corrupted, as the bitwise operation
>> on the bitfield is non-atomic.
>>
>> Ensure each flag has a separate memory location, so concurrent
>> updates do not corrupt orthogonal states.
> 
> Ouch....
> 
> Alas the fix is not sufficient on some platforms. gcc will happily use
> 32bit operations on those fields if it thinks its a performance win.
> 
> It needs to use set_bit and friends.
> 
> x86 is generally ok, but ia64 gcc will do things like load all four
> bytes, mask and write the dword back. I believe ARM gcc may also
> sometimes generate similar results.

Ahh. Thanks for the insight, Alan.

But set_bit() et. al. will generate an incredible amount of churn;
what if I split the fields up to prevent false-sharing?

--- >% ---

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1c3316a..36d3cf7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -252,6 +252,11 @@ struct tty_struct {
 	struct rw_semaphore termios_rwsem;
 	struct mutex winsize_mutex;
 	spinlock_t ctrl_lock;
+	unsigned char ctrl_status;	/* ctrl_lock fields */
+	bool packet;
 	spinlock_t flow_lock;
+	unsigned char stopped:1,	/* flow_lock fields */
+		      flow_stopped:1;
 	/* Termios values are protected by the termios rwsem */
 	struct ktermios termios, termios_locked;
 	struct termiox *termiox;	/* May be NULL for unsupported */
@@ -261,8 +266,7 @@ struct tty_struct {
 	unsigned long flags;
 	int count;
 	struct winsize winsize;		/* winsize_mutex */
-	unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
-	unsigned char ctrl_status;	/* ctrl_lock */
+	bool hw_stopped;
 	unsigned int receive_room;	/* Bytes free for queue */
 	int flow_change;


>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>  include/linux/tty.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/tty.h b/include/linux/tty.h
>> index 1c3316a..7cf61cb 100644
>> --- a/include/linux/tty.h
>> +++ b/include/linux/tty.h
>> @@ -261,7 +261,10 @@ struct tty_struct {
>>  	unsigned long flags;
>>  	int count;
>>  	struct winsize winsize;		/* winsize_mutex */
>> -	unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
>> +	bool stopped;
>> +	bool hw_stopped;
>> +	bool flow_stopped;
>> +	bool packet;
>>  	unsigned char ctrl_status;	/* ctrl_lock */
>>  	unsigned int receive_room;	/* Bytes free for queue */
>>  	int flow_change;

