From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ patch 1/7] drivers/serial/jsm: new serial device driver
Date: Sun, 27 Feb 2005 19:49:52 -0500
Message-ID: <42226AB0.90303@pobox.com>
References: <422259EF.90104@us.ltcfwd.linux.ibm.com> <71DF725E-891C-11D9-8040-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32144 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261532AbVB1AuG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Feb 2005 19:50:06 -0500
In-Reply-To: <71DF725E-891C-11D9-8040-000393ACC76E@mac.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Kyle Moffett wrote:
> On Feb 27, 2005, at 18:38, Wen Xiong wrote:
> 
>> +/*
>> + * jsm_init_globals()
>> + *
>> + * This is where we initialize the globals from the static insmod
>> + * configuration variables.  These are declared near the head of
>> + * this file.
>> + */
>> +static void jsm_init_globals(void)
>> +{
>> +    int i = 0;
>> +
>> +    jsm_rawreadok        = rawreadok;
>> +    jsm_trcbuf_size        = trcbuf_size;
>> +    jsm_debug        = debug;
>> +
>> +    for (i = 0; i < MAXBOARDS; i++) {
>> +        jsm_Board[i] = NULL;
>> +        jsm_board_slot[i] = (char *)kmalloc(20, GFP_KERNEL);
>> +        memset(jsm_board_slot[i], 0, 20);
>> +    }
> 
> 
> Instead of several 20-byte kmallocs, you could help reduce memory
> usage and fragmentation with something like this:
> 
> static void *jsm_board_slot_mem;
> 
> jsm_board_slot_mem = kmalloc(20*MAXBOARDS, GFP_KERNEL);
> memset(jsm_board_slot_mem, 0, 20*MAXBOARDS)
> for (i = 0; i < MAXBOARDS; i++) {
>     jsm_Board[i] = NULL;
>     jsm_board_slot[i] = &jsm_board_slot_mem[20*i];
> }
> 
> Then free like this:
> kfree(jsm_board_slot_mem);

Agree with your initial comment, but you missed an overall point: 
MAXBOARDS must be eliminated completely.  We do not impose such limits 
in Linux.

Information should be allocated on a per-device basis.


> On the other hand, it might be nice to have all these structures
> dynamically allocated, so that the no-boards case only uses the 8 or
> 16 bytes of RAM required for a struct list_head.  In that case you
> could clump the other board info into a single struct instead of
> multiple independent static arrays.  Something like this might work:
> 
> struct jsm_board_instance {
>     struct list_head board_list;
>     struct board_t board;
>     char slot[20];
>     [...etc...]
> };
> static struct list_head jsm_board_list = LIST_HEAD_INIT(jsm_board_list);
> static spinlock_t jsm_board_list_lock = SPIN_LOCK_UNLOCKED;
> 
> Then when doing hardware add/remove, take the lock and do the list
> manipulation, then unlock.

Correct-a-mundo!

This is the way it should be done.

	Jeff


