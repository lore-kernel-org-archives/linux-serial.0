From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ patch 1/7] drivers/serial/jsm: new serial device driver
Date: Sun, 27 Feb 2005 19:05:24 -0500
Message-ID: <71DF725E-891C-11D9-8040-000393ACC76E@mac.com>
References: <422259EF.90104@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from smtpout.mac.com ([17.250.248.47]:25056 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261342AbVB1AFa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Feb 2005 19:05:30 -0500
In-Reply-To: <422259EF.90104@us.ltcfwd.linux.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Feb 27, 2005, at 18:38, Wen Xiong wrote:
> +/*
> + * jsm_init_globals()
> + *
> + * This is where we initialize the globals from the static insmod
> + * configuration variables.  These are declared near the head of
> + * this file.
> + */
> +static void jsm_init_globals(void)
> +{
> +	int i = 0;
> +
> +	jsm_rawreadok		= rawreadok;
> +	jsm_trcbuf_size		= trcbuf_size;
> +	jsm_debug		= debug;
> +
> +	for (i = 0; i < MAXBOARDS; i++) {
> +		jsm_Board[i] = NULL;
> +		jsm_board_slot[i] = (char *)kmalloc(20, GFP_KERNEL);
> +		memset(jsm_board_slot[i], 0, 20);
> +	}

Instead of several 20-byte kmallocs, you could help reduce memory
usage and fragmentation with something like this:

static void *jsm_board_slot_mem;

jsm_board_slot_mem = kmalloc(20*MAXBOARDS, GFP_KERNEL);
memset(jsm_board_slot_mem, 0, 20*MAXBOARDS)
for (i = 0; i < MAXBOARDS; i++) {
	jsm_Board[i] = NULL;
	jsm_board_slot[i] = &jsm_board_slot_mem[20*i];
}

Then free like this:
kfree(jsm_board_slot_mem);

On the other hand, it might be nice to have all these structures
dynamically allocated, so that the no-boards case only uses the 8 or
16 bytes of RAM required for a struct list_head.  In that case you
could clump the other board info into a single struct instead of
multiple independent static arrays.  Something like this might work:

struct jsm_board_instance {
	struct list_head board_list;
	struct board_t board;
	char slot[20];
	[...etc...]
};
static struct list_head jsm_board_list = LIST_HEAD_INIT(jsm_board_list);
static spinlock_t jsm_board_list_lock = SPIN_LOCK_UNLOCKED;

Then when doing hardware add/remove, take the lock and do the list
manipulation, then unlock.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


