From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: plug a use-after-free in TIOCGETD ioctl
Date: Thu, 7 Jan 2016 08:38:04 -0800
Message-ID: <568E946C.60703@hurleysoftware.com>
References: <1452178680-30284-1-git-send-email-mguzik@redhat.com>
 <20160107161418.GA28297@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160107161418.GA28297@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mateusz Guzik <mguzik@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org, milos@redhat.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/07/2016 08:14 AM, Greg Kroah-Hartman wrote:
> Adding Peter and linux-serial to the list here, as Peter has been doing
> a ton of work in this area...
> 
> Peter, does this seem sane with the tty locking rules?
> 
> thanks,
> 
> greg k-h

No.

Fix for this is right here:
http://lkml.iu.edu/hypermail/linux/kernel/1511.3/03045.html

Regards,
Peter Hurley

> On Thu, Jan 07, 2016 at 03:58:00PM +0100, Mateusz Guzik wrote:
>> When the line discipline is being changed, the old one is freed.
>> However, the handler for TIOCGETD would dereference it without taking
>> any locks, in effect possibly reading freed memory.
>>
>> Line discipline changes are protected with tty lock. Use it on reader
>> side as well.
>>
>> CVE: CVE-2016-0723
>> Found-by: Milos Vyletel <milos@redhat.com>
>> Signed-off-by: Mateusz Guzik <mguzik@redhat.com>
>> ---
>>  drivers/tty/tty_io.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
>> index 892c923..1b10469 100644
>> --- a/drivers/tty/tty_io.c
>> +++ b/drivers/tty/tty_io.c
>> @@ -2626,6 +2626,27 @@ static int tiocgsid(struct tty_struct *tty, struct tty_struct *real_tty, pid_t _
>>  }
>>  
>>  /**
>> + *	tiocgetd	-	get line discipline
>> + *	@tty: tty device
>> + *	@p: pointer to returned line discipline
>> + *
>> + *	Get the line discipline associated with the tty.
>> + *
>> + *	Locking: none
>> + */
>> +
>> +static int tiocgetd(struct tty_struct *tty, int __user *p)
>> +{
>> +	int ldisc;
>> +
>> +	tty_lock(tty);
>> +	ldisc = tty->ldisc->ops->num;
>> +	tty_unlock(tty);
>> +
>> +	return put_user(ldisc, p);
>> +}
>> +
>> +/**
>>   *	tiocsetd	-	set line discipline
>>   *	@tty: tty device
>>   *	@p: pointer to user data
>> @@ -2874,7 +2895,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>  	case TIOCGSID:
>>  		return tiocgsid(tty, real_tty, p);
>>  	case TIOCGETD:
>> -		return put_user(tty->ldisc->ops->num, (int __user *)p);
>> +		return tiocgetd(tty, p);
>>  	case TIOCSETD:
>>  		return tiocsetd(tty, p);
>>  	case TIOCVHANGUP:
>> -- 
>> 1.8.3.1
