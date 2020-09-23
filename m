Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC00C2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 20:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594CF2376E
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 20:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWUIC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWUIB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 16:08:01 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A57206DB;
        Wed, 23 Sep 2020 20:07:59 +0000 (UTC)
Date:   Wed, 23 Sep 2020 16:07:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 4/9] surface_aggregator: Add trace points
Message-ID: <20200923160757.51e773a0@oasis.local.home>
In-Reply-To: <20200923151511.3842150-5-luzmaximilian@gmail.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
        <20200923151511.3842150-5-luzmaximilian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 23 Sep 2020 17:15:06 +0200
Maximilian Luz <luzmaximilian@gmail.com> wrote:

> Add trace points to the Surface Aggregator subsystem core. These trace
> points can be used to track packets, requests, and allocations. They are
> further intended for debugging and testing/validation, specifically in
> combination with the error injection capabilities introduced in the
> subsequent commit.

I'm impressed! This uses some of the advanced features of the tracing
infrastructure. But I still have some comments to make about the layout
of the TP_STRUCT__entry() fields.

> 

> diff --git a/drivers/misc/surface_aggregator/trace.h b/drivers/misc/surface_aggregator/trace.h
> new file mode 100644
> index 000000000000..eb2e3e1457de
> --- /dev/null
> +++ b/drivers/misc/surface_aggregator/trace.h
> @@ -0,0 +1,612 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM surface_aggregator
> +
> +#if !defined(_SURFACE_AGGREGATOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _SURFACE_AGGREGATOR_TRACE_H
> +
> +#include <linux/surface_aggregator/serial_hub.h>
> +
> +#include <asm/unaligned.h>
> +#include <linux/tracepoint.h>
> +
> +
> +TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_DATA_SEQ);
> +TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_DATA_NSQ);
> +TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_ACK);
> +TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_NAK);

Kudos on using TRACE_DEFINE_ENUM :-)


> +
> +#define ssam_show_generic_u8_field(value)				\
> +	__print_symbolic(value,						\
> +		{ SSAM_U8_FIELD_NOT_APPLICABLE,		"N/A" }		\
> +	)
> +
> +
> +#define ssam_show_frame_type(ty)					\
> +	__print_symbolic(ty,						\
> +		{ SSH_FRAME_TYPE_DATA_SEQ,		"DSEQ" },	\
> +		{ SSH_FRAME_TYPE_DATA_NSQ,		"DNSQ" },	\
> +		{ SSH_FRAME_TYPE_ACK,			"ACK"  },	\
> +		{ SSH_FRAME_TYPE_NAK,			"NAK"  }	\
> +	)
> +
> +#define ssam_show_packet_type(type)					\
> +	__print_flags(flags & SSH_PACKET_FLAGS_TY_MASK, "",		\
> +		{ BIT(SSH_PACKET_TY_FLUSH_BIT),		"F" },		\
> +		{ BIT(SSH_PACKET_TY_SEQUENCED_BIT),	"S" },		\
> +		{ BIT(SSH_PACKET_TY_BLOCKING_BIT),	"B" }		\

More kudos on proper usage of __print_symbolic() and __print_flags() :-)



> +DECLARE_EVENT_CLASS(ssam_packet_class,
> +	TP_PROTO(const struct ssh_packet *packet),
> +
> +	TP_ARGS(packet),
> +
> +	TP_STRUCT__entry(
> +		__array(char, uid, SSAM_PTR_UID_LEN)
> +		__field(u8, priority)
> +		__field(u16, length)
> +		__field(unsigned long, state)
> +		__field(u16, seq)


Order matters above to keep the events as compact as possible. The more
compact they are, the more events you can store without loss.

Now with SSAM_PTR_UID_LEN = 9, the above is (on a 64 bit system);

	9 bytes;
	1 byte;
	2 bytes;
	8 bytes;
	2 bytes;

The ftrace ring buffer is 4 byte aligned. As words and long words are
also 4 byte aligned, there's not much different to change. But it is
possible that the compiler might add 4 byte padding between the long
word "length" and "priority". Note, these are not packed structures.

Testing this out with the following code:

 $ cat << EOF > test.c
struct test {
	unsigned char array[9];
	unsigned char priority;
	unsigned short length;
	unsigned long state;
	unsigned short seq;
};

static struct test x;

void receive_x(struct test *p)
{
	p = &x;
}
EOF

 $ gcc -g -c -o test.o test.c
 $ pahole test.o
struct test {
	unsigned char              array[9];             /*     0     9 */
	unsigned char              priority;             /*     9     1 */
	short unsigned int         length;               /*    10     2 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          state;                /*    16     8 */
	short unsigned int         seq;                  /*    24     2 */

	/* size: 32, cachelines: 1, members: 5 */
	/* sum members: 22, holes: 1, sum holes: 4 */
	/* padding: 6 */
	/* last cacheline: 32 bytes */
};

You do see a hole between length and state. Now if we were to move this
around a little.

 $ cat <<EOF > test2.c
struct test {
	unsigned long state;
	unsigned char array[9];
	unsigned char priority;
	unsigned short length;
	unsigned short seq;
};

static struct test x;

void receive_x(struct test *p)
{
	p = &x;
}
EOF

 $ gcc -g -c -o test2 test2.c
 $ pahole test2.o
struct test {
	long unsigned int          state;                /*     0     8 */
	unsigned char              array[9];             /*     8     9 */
	unsigned char              priority;             /*    17     1 */
	short unsigned int         length;               /*    18     2 */
	short unsigned int         seq;                  /*    20     2 */

	/* size: 24, cachelines: 1, members: 5 */
	/* padding: 2 */
	/* last cacheline: 24 bytes */
};


We get a more compact structure with:

	TP_STRUCT__entry(
		__field(unsigned long, state)
		__array(char, uid, SSAM_PTR_UID_LEN)
		__field(u8, priority)
		__field(u16, length)
		__field(u16, seq)
	),


Note, you can find pahole here:

   https://git.kernel.org/pub/scm/devel/pahole/pahole.git


> +	),


> +
> +
> +DECLARE_EVENT_CLASS(ssam_packet_status_class,
> +	TP_PROTO(const struct ssh_packet *packet, int status),
> +
> +	TP_ARGS(packet, status),
> +
> +	TP_STRUCT__entry(
> +		__array(char, uid, SSAM_PTR_UID_LEN)
> +		__field(u8, priority)
> +		__field(u16, length)
> +		__field(unsigned long, state)
> +		__field(u16, seq)
> +		__field(int, status)

The above can be better compacted with:

	TP_STRUCT__entry(
		__field(unsigned long, state)
		__field(int, status)
		__array(char, uid, SSAM_PTR_UID_LEN)
		__field(u8, priority)
		__field(u16, length)
		__field(u16, seq)


> +	),
> +
> +	TP_fast_assign(
> +		ssam_trace_ptr_uid(packet, __entry->uid);
> +		__entry->priority = READ_ONCE(packet->priority);
> +		__entry->length = packet->data.len;
> +		__entry->state = READ_ONCE(packet->state);
> +		__entry->seq = ssam_trace_get_packet_seq(packet);
> +		__entry->status = status;
> +	),
> +
> +	TP_printk("uid=%s, seq=%s, ty=%s, pri=0x%02x, len=%u, sta=%s, status=%d",
> +		__entry->uid,
> +		ssam_show_packet_seq(__entry->seq),
> +		ssam_show_packet_type(__entry->state),
> +		__entry->priority,
> +		__entry->length,
> +		ssam_show_packet_state(__entry->state),
> +		__entry->status
> +	)


> +DECLARE_EVENT_CLASS(ssam_request_class,
> +	TP_PROTO(const struct ssh_request *request),
> +
> +	TP_ARGS(request),
> +
> +	TP_STRUCT__entry(
> +		__array(char, uid, SSAM_PTR_UID_LEN)
> +		__field(unsigned long, state)
> +		__field(u32, rqid)
> +		__field(u8, tc)
> +		__field(u16, cid)
> +		__field(u16, iid)

The above should be:

	TP_STRUCT__entry(
		__field(unsigned long, state)
		__field(u32, rqid)
		__array(char, uid, SSAM_PTR_UID_LEN)
		__field(u8, tc)
		__field(u16, cid)
		__field(u16, iid)


> +	),
> +
> +	TP_fast_assign(
> +		const struct ssh_packet *p = &request->packet;
> +
> +		// use packet for UID so we can match requests to packets
> +		ssam_trace_ptr_uid(p, __entry->uid);
> +		__entry->state = READ_ONCE(request->state);
> +		__entry->rqid = ssam_trace_get_request_id(p);
> +		__entry->tc = ssam_trace_get_request_tc(p);
> +		__entry->cid = ssam_trace_get_command_field_u8(p, cid);
> +		__entry->iid = ssam_trace_get_command_field_u8(p, iid);
> +	),
> +


> +DECLARE_EVENT_CLASS(ssam_request_status_class,
> +	TP_PROTO(const struct ssh_request *request, int status),
> +
> +	TP_ARGS(request, status),
> +
> +	TP_STRUCT__entry(
> +		__array(char, uid, SSAM_PTR_UID_LEN)
> +		__field(unsigned long, state)
> +		__field(u32, rqid)
> +		__field(u8, tc)
> +		__field(u16, cid)
> +		__field(u16, iid)
> +		__field(int, status)
> +	),

The above should be:

	TP_STRUCT__entry(
		__field(unsigned long, state)
		__field(u32, rqid)
		__field(int, status)
		__array(char, uid, SSAM_PTR_UID_LEN)
		__field(u8, tc)
		__field(u16, cid)
		__field(u16, iid)
	),

> +
> +	TP_fast_assign(
> +		const struct ssh_packet *p = &request->packet;
> +
> +		// use packet for UID so we can match requests to packets
> +		ssam_trace_ptr_uid(p, __entry->uid);
> +		__entry->state = READ_ONCE(request->state);
> +		__entry->rqid = ssam_trace_get_request_id(p);
> +		__entry->tc = ssam_trace_get_request_tc(p);
> +		__entry->cid = ssam_trace_get_command_field_u8(p, cid);
> +		__entry->iid = ssam_trace_get_command_field_u8(p, iid);
> +		__entry->status = status;
> +	),


> +DECLARE_EVENT_CLASS(ssam_alloc_class,
> +	TP_PROTO(void *ptr, size_t len),
> +
> +	TP_ARGS(ptr, len),
> +
> +	TP_STRUCT__entry(
> +		__array(char, uid, SSAM_PTR_UID_LEN)
> +		__field(size_t, len)
> +	),
> +
> +	TP_fast_assign(
> +		ssam_trace_ptr_uid(ptr, __entry->uid);
> +		__entry->len = len;
> +	),
> +
> +	TP_printk("uid=%s, len=%zu", __entry->uid, __entry->len)
> +);
> +
> +#define DEFINE_SSAM_ALLOC_EVENT(name)					\
> +	DEFINE_EVENT(ssam_alloc_class, ssam_##name,			\
> +		TP_PROTO(void *ptr, size_t len),			\
> +		TP_ARGS(ptr, len)					\
> +	)
> +
> +
> +DECLARE_EVENT_CLASS(ssam_free_class,
> +	TP_PROTO(void *ptr),
> +
> +	TP_ARGS(ptr),
> +
> +	TP_STRUCT__entry(
> +		__array(char, uid, SSAM_PTR_UID_LEN)
> +		__field(size_t, len)

Even this would be better swapping the fields.

> +	),
> +
> +	TP_fast_assign(
> +		ssam_trace_ptr_uid(ptr, __entry->uid);
> +	),
> +
> +	TP_printk("uid=%s", __entry->uid)
> +);
> +
> +#define DEFINE_SSAM_FREE_EVENT(name)					\
> +	DEFINE_EVENT(ssam_free_class, ssam_##name,			\
> +		TP_PROTO(void *ptr),					\
> +		TP_ARGS(ptr)						\
> +	)
> +
> +
> +DECLARE_EVENT_CLASS(ssam_generic_uint_class,
> +	TP_PROTO(const char *property, unsigned int value),
> +
> +	TP_ARGS(property, value),
> +
> +	TP_STRUCT__entry(
> +		__string(property, property)
> +		__field(unsigned int, value)

Strings are dynamic, and hold a 2 byte buffer. May be better to switch
the above as well.

Besides the layout, this patch was done nicely. Good job!

-- Steve


> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(property, property);
> +		__entry->value = value;
> +	),
> +
> +	TP_printk("%s=%u", __get_str(property), __entry->value)
> +);
> +
> +#define
> DEFINE_SSAM_GENERIC_UINT_EVENT(name)				\
> +	DEFINE_EVENT(ssam_generic_uint_class,
> ssam_##name,		\
> +		TP_PROTO(const char *property, unsigned int
> value),	\
> +		TP_ARGS(property,
> value)				\
> +	)
> +
> +
> +DEFINE_SSAM_FRAME_EVENT(rx_frame_received);
> +DEFINE_SSAM_COMMAND_EVENT(rx_response_received);
> +DEFINE_SSAM_COMMAND_EVENT(rx_event_received);
> +
> +DEFINE_SSAM_PACKET_EVENT(packet_release);
> +DEFINE_SSAM_PACKET_EVENT(packet_submit);
> +DEFINE_SSAM_PACKET_EVENT(packet_resubmit);
> +DEFINE_SSAM_PACKET_EVENT(packet_timeout);
> +DEFINE_SSAM_PACKET_EVENT(packet_cancel);
> +DEFINE_SSAM_PACKET_STATUS_EVENT(packet_complete);
> +DEFINE_SSAM_GENERIC_UINT_EVENT(ptl_timeout_reap);
> +
> +DEFINE_SSAM_REQUEST_EVENT(request_submit);
> +DEFINE_SSAM_REQUEST_EVENT(request_timeout);
> +DEFINE_SSAM_REQUEST_EVENT(request_cancel);
> +DEFINE_SSAM_REQUEST_STATUS_EVENT(request_complete);
> +DEFINE_SSAM_GENERIC_UINT_EVENT(rtl_timeout_reap);
> +
> +DEFINE_SSAM_ALLOC_EVENT(ctrl_packet_alloc);
> +DEFINE_SSAM_FREE_EVENT(ctrl_packet_free);
> +
> +DEFINE_SSAM_ALLOC_EVENT(event_item_alloc);
> +DEFINE_SSAM_FREE_EVENT(event_item_free);
> +
> +#endif /* _SURFACE_AGGREGATOR_TRACE_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE trace
> +
> +#include <trace/define_trace.h>

