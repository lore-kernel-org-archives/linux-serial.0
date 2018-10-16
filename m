From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Date: Tue, 16 Oct 2018 16:21:58 +0200
Message-ID: <20181016142158.GA2603@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
 <20181016125415.GA3121@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016125415.GA3121@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 16, 2018 at 02:54:15PM +0200, Peter Zijlstra wrote:
> printk will determine the current context:
> 
>   task, softirq, hardirq or NMI
> 
> and pick the corresponding per-cpu line buffer and do the vsnprintf()

We need 4, but we don't need to do the exact context determination for
this. We can keep a simple counter:

#define MAX_IDX 4	/* task, sirq, hirq, nmi */
#define MAX_LEN 1020	/* sizeof(struct line_buffer) < 4k */

struct line_buffers {
	int idx;
	char line[MAX_IDX][MAX_LEN];
};

static DEFINE_PER_CPU(struct line_buffers, lbs);

static char *get_linebuf(void)
{
	struct line_buffers *lbp = this_cpu_ptr(&lbs);
	int idx;

	idx = lbp->idx++;
	return lbp->linx[idx];
}

static void put_linbuf(void)
{
	this_cpu_dec(lbs.idx);
}

> thing. Then we have the actual line length and content. With the length
> we reserve the bytes from the global buffer, we memcpy into the buffer
> and commit.
