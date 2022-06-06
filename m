Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E8C43334
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jun 2022 13:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbiFFNkb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jun 2022 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbiFFNk3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jun 2022 09:40:29 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC79CFE1D
        for <linux-serial@vger.kernel.org>; Mon,  6 Jun 2022 06:40:28 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i19so10198397qvu.13
        for <linux-serial@vger.kernel.org>; Mon, 06 Jun 2022 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qbslnqs5bRxuKY7dTeJm8HSCGpLEMhq9qSHT4K4tIV0=;
        b=jvGS8VUqz2n7Qu4DwSD5cmn5Xiv9Xc5jAfpcNzOXOiI2lwhWDZgt/kqnA56Fywj48y
         sd0zN7zRIj2mOzelf+2Bj9YQsPdMtLzFzU8q9RGQU7jdZm4N6HZRSPDeSFh988cSDMfM
         +uigLZ89cRDwLYp2kd/nFaGLIpyxPkNhqm1ej0Z8V+cg9UfS3rAxwWyiQPLYbx8yEzJb
         M5h9Wpp8/CafXUfYMoIxSHQR7b33eUMi9qHfzydpMbyuugfQ/qhBDov8xO1i1IHdfWXv
         HpzH7zJEmwRFceQCdi8Z9T4xqzyO6lVCPw3LnuBferD86tXVDUyxqov/5sgaQewG6yHT
         kLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qbslnqs5bRxuKY7dTeJm8HSCGpLEMhq9qSHT4K4tIV0=;
        b=06KS+DDT3pJLEJhg+7dlppl7v+mrTO4XOmODKjzieaQoyjR3tlQF00we6MLB2nkb07
         DoIB7bQDT9UGeBVuxJEayY8HSwXGDJY76oPCsjLJkcOph/Lv/wU62uQt7HGCF/lTeJMC
         mSaA1t7cnhXpgULCItDAYy8A0f4YfJxKHGxfccezUW9GZKzxlfJQ1btoDO+Xympar3P9
         UF2zsyVrcYP3v1Dt+PHN8jh0ag1WfQGAsE+MCxvSIxiTGMjQP8TJCg8zYVdnKqmFBjn/
         ZfKoo4yzCgiQY/NUxILzKXt9wXCP4iZECdqS5BjKwKuzBqM1lY9G5FKqoUYJyysqLIbh
         mH5g==
X-Gm-Message-State: AOAM532gSnQUs91FF80iN+jaEp+T9filsMbc1i8ZaBNGUJqGaXEbrnE8
        I10dMFU2Eqcf4EKKjQI3ACMDt42T2T4cTLVlB8Y=
X-Google-Smtp-Source: ABdhPJyfxteSu1thlhObGPgGhZoHq6IXxqOxFg7SApVIqOZxoXVogaY22DnuhO/IMd9C9LLFW01dYWzdvOxzldEWlP8=
X-Received: by 2002:a0c:fca9:0:b0:462:60b4:26ce with SMTP id
 h9-20020a0cfca9000000b0046260b426cemr49990667qvq.6.1654522827567; Mon, 06 Jun
 2022 06:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com>
 <YpczhMOT5BvxqL/P@kroah.com> <CAPmgiULBpWvPV4WzBFY1JMcijg_EkP+w7q6rAWVgdp196WGKXQ@mail.gmail.com>
 <318878-5fd6-36cd-2670-8ac871b6e2c6@linux.intel.com>
In-Reply-To: <318878-5fd6-36cd-2670-8ac871b6e2c6@linux.intel.com>
From:   cael <juanfengpy@gmail.com>
Date:   Mon, 6 Jun 2022 21:40:16 +0800
Message-ID: <CAPmgiUL4XU7qeLvCdTe=G0AWMStKVu78GjmdPMzakLqgEei9yQ@mail.gmail.com>
Subject: Re: tty: fix a possible hang on tty device
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000692fb405e0c79da4"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--000000000000692fb405e0c79da4
Content-Type: text/plain; charset="UTF-8"

From: cael <juanfengpy@gmail.com>
Subject:[PATCH v3] tty: fix a possible hang on tty device

We have met a hang on pty device, the reader was blocking
at epoll on master side, the writer was sleeping at wait_woken
inside n_tty_write on slave side, and the write buffer on
tty_port was full, we found that the reader and writer would
never be woken again and block forever.

The problem was caused by a race between reader and kworker:
n_tty_read(reader):  n_tty_receive_buf_common(kworker):
                    |room = N_TTY_BUF_SIZE - (ldata->read_head - tail)
                    |room <= 0
copy_from_read_buf()|
n_tty_kick_worker() |
                    |ldata->no_room = true

After writing to slave device, writer wakes up kworker to flush
data on tty_port to reader, and the kworker finds that reader
has no room to store data so room <= 0 is met. At this moment,
reader consumes all the data on reader buffer and call
n_tty_kick_worker to check ldata->no_room which is false and
reader quits reading. Then kworker sets ldata->no_room=true
and quits too.

If write buffer is not full, writer will wake kworker to flush data
again after following writes, but if writer buffer is full and writer
goes to sleep, kworker will never be woken again and tty device is
blocked.

This problem can be solved with a check for read buffer size inside
n_tty_receive_buf_common, if read buffer is empty and ldata->no_room
is true, a call to n_tty_kick_worker is necessary to keep flushing
data to reader.

Signed-off-by: cael <juanfengpy@gmail.com>

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..544f782b9a11 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -201,8 +201,8 @@ static void n_tty_kick_worker(struct tty_struct *tty)
        struct n_tty_data *ldata = tty->disc_data;

        /* Did the input worker stop? Restart it */
-       if (unlikely(ldata->no_room)) {
-               ldata->no_room = 0;
+       if (unlikely(READ_ONCE(ldata->no_room))) {
+               WRITE_ONCE(ldata->no_room, 0);

                WARN_RATELIMIT(tty->port->itty == NULL,
                                "scheduling with invalid itty\n");
@@ -1632,7 +1632,7 @@ n_tty_receive_buf_common(struct tty_struct *tty,
const unsigned char *cp,
                        if (overflow && room < 0)
                                ldata->read_head--;
                        room = overflow;
-                       ldata->no_room = flow && !room;
+                       WRITE_ONCE(ldata->no_room, flow && !room);
                } else
                        overflow = 0;

@@ -1663,6 +1663,24 @@ n_tty_receive_buf_common(struct tty_struct
*tty, const unsigned char *cp,
        } else
                n_tty_check_throttle(tty);

+       if (unlikely(ldata->no_room)) {
+               /*
+                * Barrier here is to ensure to read the latest read_tail in
+                * chars_in_buffer() and to make sure that read_tail
is not loaded
+                * before ldata->no_room is set, otherwise, following
race may occur:
+                * n_tty_receive_buf_common() |n_tty_read()
+                * chars_in_buffer() > 0      |
+                *
|copy_from_read_buf()->chars_in_buffer()==0
+                *                            |if (ldata->no_room)
+                * ldata->no_room = 1         |
+                * Then both kworker and reader will fail to kick
n_tty_kick_worker(),
+                * smp_mb is paired with smp_mb() in n_tty_read().
+                */
+               smp_mb();
+               if (!chars_in_buffer(tty))
+                       n_tty_kick_worker(tty);
+       }
+
        up_read(&tty->termios_rwsem);

        return rcvd;
@@ -2180,8 +2198,23 @@ static ssize_t n_tty_read(struct tty_struct
*tty, struct file *file,
                if (time)
                        timeout = time;
        }
-       if (tail != ldata->read_tail)
+       if (tail != ldata->read_tail) {
+               /*
+                * Make sure no_room is not read before setting read_tail,
+                * otherwise, following race may occur:
+                * n_tty_read()
|n_tty_receive_buf_common()
+                * if(ldata->no_room)->false            |
+                *                                      |ldata->no_room = 1
+                *                                      |char_in_buffer() > 0
+                * ldata->read_tail = ldata->commit_head|
+                * Then copy_from_read_buf() in reader consumes all the data
+                * in read buffer, both reader and kworker will fail to kick
+                * tty_buffer_restart_work().
+                * smp_mb is paired with smp_mb() in n_tty_receive_buf_common().
+                */
+               smp_mb();
                n_tty_kick_worker(tty);
+       }
        up_read(&tty->termios_rwsem);

        remove_wait_queue(&tty->read_wait, &wait);
-- 
2.27.0

--000000000000692fb405e0c79da4
Content-Type: application/octet-stream; 
	name="0001-PATCH-v3-tty-fix-a-possible-hang-on-tty-device.patch"
Content-Disposition: attachment; 
	filename="0001-PATCH-v3-tty-fix-a-possible-hang-on-tty-device.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l42s4lxi0>
X-Attachment-Id: f_l42s4lxi0

RnJvbSA2ZDIxM2JkOTE2ZmNlOTE0MDU1NzIyMWE3ZWZmMGQ2NWJkMzNkZjU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBjYWVsIDxqdWFuZmVuZ3B5QGdtYWlsLmNvbT4KRGF0ZTogTW9u
LCAyMyBNYXkgMjAyMiAyMDo1Mzo1NSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFtQQVRDSCB2M10g
dHR5OiBmaXggYSBwb3NzaWJsZSBoYW5nIG9uIHR0eSBkZXZpY2UKCldlIGhhdmUgbWV0IGEgaGFu
ZyBvbiBwdHkgZGV2aWNlLCB0aGUgcmVhZGVyIHdhcyBibG9ja2luZwphdCBlcG9sbCBvbiBtYXN0
ZXIgc2lkZSwgdGhlIHdyaXRlciB3YXMgc2xlZXBpbmcgYXQgd2FpdF93b2tlbgppbnNpZGUgbl90
dHlfd3JpdGUgb24gc2xhdmUgc2lkZSwgYW5kIHRoZSB3cml0ZSBidWZmZXIgb24KdHR5X3BvcnQg
d2FzIGZ1bGwsIHdlIGZvdW5kIHRoYXQgdGhlIHJlYWRlciBhbmQgd3JpdGVyIHdvdWxkCm5ldmVy
IGJlIHdva2VuIGFnYWluIGFuZCBibG9jayBmb3JldmVyLgoKVGhlIHByb2JsZW0gd2FzIGNhdXNl
ZCBieSBhIHJhY2UgYmV0d2VlbiByZWFkZXIgYW5kIGt3b3JrZXI6Cm5fdHR5X3JlYWQocmVhZGVy
KTogIG5fdHR5X3JlY2VpdmVfYnVmX2NvbW1vbihrd29ya2VyKToKICAgICAgICAgICAgICAgICAg
ICB8cm9vbSA9IE5fVFRZX0JVRl9TSVpFIC0gKGxkYXRhLT5yZWFkX2hlYWQgLSB0YWlsKQogICAg
ICAgICAgICAgICAgICAgIHxyb29tIDw9IDAKY29weV9mcm9tX3JlYWRfYnVmKCl8Cm5fdHR5X2tp
Y2tfd29ya2VyKCkgfAogICAgICAgICAgICAgICAgICAgIHxsZGF0YS0+bm9fcm9vbSA9IHRydWUK
CkFmdGVyIHdyaXRpbmcgdG8gc2xhdmUgZGV2aWNlLCB3cml0ZXIgd2FrZXMgdXAga3dvcmtlciB0
byBmbHVzaApkYXRhIG9uIHR0eV9wb3J0IHRvIHJlYWRlciwgYW5kIHRoZSBrd29ya2VyIGZpbmRz
IHRoYXQgcmVhZGVyCmhhcyBubyByb29tIHRvIHN0b3JlIGRhdGEgc28gcm9vbSA8PSAwIGlzIG1l
dC4gQXQgdGhpcyBtb21lbnQsCnJlYWRlciBjb25zdW1lcyBhbGwgdGhlIGRhdGEgb24gcmVhZGVy
IGJ1ZmZlciBhbmQgY2FsbApuX3R0eV9raWNrX3dvcmtlciB0byBjaGVjayBsZGF0YS0+bm9fcm9v
bSB3aGljaCBpcyBmYWxzZSBhbmQKcmVhZGVyIHF1aXRzIHJlYWRpbmcuIFRoZW4ga3dvcmtlciBz
ZXRzIGxkYXRhLT5ub19yb29tPXRydWUKYW5kIHF1aXRzIHRvby4KCklmIHdyaXRlIGJ1ZmZlciBp
cyBub3QgZnVsbCwgd3JpdGVyIHdpbGwgd2FrZSBrd29ya2VyIHRvIGZsdXNoIGRhdGEKYWdhaW4g
YWZ0ZXIgZm9sbG93aW5nIHdyaXRlcywgYnV0IGlmIHdyaXRlciBidWZmZXIgaXMgZnVsbCBhbmQg
d3JpdGVyCmdvZXMgdG8gc2xlZXAsIGt3b3JrZXIgd2lsbCBuZXZlciBiZSB3b2tlbiBhZ2FpbiBh
bmQgdHR5IGRldmljZSBpcwpibG9ja2VkLgoKVGhpcyBwcm9ibGVtIGNhbiBiZSBzb2x2ZWQgd2l0
aCBhIGNoZWNrIGZvciByZWFkIGJ1ZmZlciBzaXplIGluc2lkZQpuX3R0eV9yZWNlaXZlX2J1Zl9j
b21tb24sIGlmIHJlYWQgYnVmZmVyIGlzIGVtcHR5IGFuZCBsZGF0YS0+bm9fcm9vbQppcyB0cnVl
LCBhIGNhbGwgdG8gbl90dHlfa2lja193b3JrZXIgaXMgbmVjZXNzYXJ5IHRvIGtlZXAgZmx1c2hp
bmcKZGF0YSB0byByZWFkZXIuCgpTaWduZWQtb2ZmLWJ5OiBjYWVsIDxqdWFuZmVuZ3B5QGdtYWls
LmNvbT4KCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9uX3R0eS5jIGIvZHJpdmVycy90dHkvbl90
dHkuYwppbmRleCBlZmM3MjEwNGM4NDAuLjU0NGY3ODJiOWExMSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy90dHkvbl90dHkuYworKysgYi9kcml2ZXJzL3R0eS9uX3R0eS5jCkBAIC0yMDEsOCArMjAxLDgg
QEAgc3RhdGljIHZvaWQgbl90dHlfa2lja193b3JrZXIoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSkK
IAlzdHJ1Y3Qgbl90dHlfZGF0YSAqbGRhdGEgPSB0dHktPmRpc2NfZGF0YTsKIAogCS8qIERpZCB0
aGUgaW5wdXQgd29ya2VyIHN0b3A/IFJlc3RhcnQgaXQgKi8KLQlpZiAodW5saWtlbHkobGRhdGEt
Pm5vX3Jvb20pKSB7Ci0JCWxkYXRhLT5ub19yb29tID0gMDsKKwlpZiAodW5saWtlbHkoUkVBRF9P
TkNFKGxkYXRhLT5ub19yb29tKSkpIHsKKwkJV1JJVEVfT05DRShsZGF0YS0+bm9fcm9vbSwgMCk7
CiAKIAkJV0FSTl9SQVRFTElNSVQodHR5LT5wb3J0LT5pdHR5ID09IE5VTEwsCiAJCQkJInNjaGVk
dWxpbmcgd2l0aCBpbnZhbGlkIGl0dHlcbiIpOwpAQCAtMTYzMiw3ICsxNjMyLDcgQEAgbl90dHlf
cmVjZWl2ZV9idWZfY29tbW9uKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIGNvbnN0IHVuc2lnbmVk
IGNoYXIgKmNwLAogCQkJaWYgKG92ZXJmbG93ICYmIHJvb20gPCAwKQogCQkJCWxkYXRhLT5yZWFk
X2hlYWQtLTsKIAkJCXJvb20gPSBvdmVyZmxvdzsKLQkJCWxkYXRhLT5ub19yb29tID0gZmxvdyAm
JiAhcm9vbTsKKwkJCVdSSVRFX09OQ0UobGRhdGEtPm5vX3Jvb20sIGZsb3cgJiYgIXJvb20pOwog
CQl9IGVsc2UKIAkJCW92ZXJmbG93ID0gMDsKIApAQCAtMTY2Myw2ICsxNjYzLDI0IEBAIG5fdHR5
X3JlY2VpdmVfYnVmX2NvbW1vbihzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBjb25zdCB1bnNpZ25l
ZCBjaGFyICpjcCwKIAl9IGVsc2UKIAkJbl90dHlfY2hlY2tfdGhyb3R0bGUodHR5KTsKIAorCWlm
ICh1bmxpa2VseShsZGF0YS0+bm9fcm9vbSkpIHsKKwkJLyoKKwkJICogQmFycmllciBoZXJlIGlz
IHRvIGVuc3VyZSB0byByZWFkIHRoZSBsYXRlc3QgcmVhZF90YWlsIGluCisJCSAqIGNoYXJzX2lu
X2J1ZmZlcigpIGFuZCB0byBtYWtlIHN1cmUgdGhhdCByZWFkX3RhaWwgaXMgbm90IGxvYWRlZAor
CQkgKiBiZWZvcmUgbGRhdGEtPm5vX3Jvb20gaXMgc2V0LCBvdGhlcndpc2UsIGZvbGxvd2luZyBy
YWNlIG1heSBvY2N1cjoKKwkJICogbl90dHlfcmVjZWl2ZV9idWZfY29tbW9uKCkgfG5fdHR5X3Jl
YWQoKQorCQkgKiBjaGFyc19pbl9idWZmZXIoKSA+IDAgICAgICB8CisJCSAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHxjb3B5X2Zyb21fcmVhZF9idWYoKS0+Y2hhcnNfaW5fYnVmZmVyKCk9
PTAKKwkJICogICAgICAgICAgICAgICAgICAgICAgICAgICAgfGlmIChsZGF0YS0+bm9fcm9vbSkK
KwkJICogbGRhdGEtPm5vX3Jvb20gPSAxICAgICAgICAgfAorCQkgKiBUaGVuIGJvdGgga3dvcmtl
ciBhbmQgcmVhZGVyIHdpbGwgZmFpbCB0byBraWNrIG5fdHR5X2tpY2tfd29ya2VyKCksCisJCSAq
IHNtcF9tYiBpcyBwYWlyZWQgd2l0aCBzbXBfbWIoKSBpbiBuX3R0eV9yZWFkKCkuCisJCSAqLwor
CQlzbXBfbWIoKTsKKwkJaWYgKCFjaGFyc19pbl9idWZmZXIodHR5KSkKKwkJCW5fdHR5X2tpY2tf
d29ya2VyKHR0eSk7CisJfQorCiAJdXBfcmVhZCgmdHR5LT50ZXJtaW9zX3J3c2VtKTsKIAogCXJl
dHVybiByY3ZkOwpAQCAtMjE4MCw4ICsyMTk4LDIzIEBAIHN0YXRpYyBzc2l6ZV90IG5fdHR5X3Jl
YWQoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgc3RydWN0IGZpbGUgKmZpbGUsCiAJCWlmICh0aW1l
KQogCQkJdGltZW91dCA9IHRpbWU7CiAJfQotCWlmICh0YWlsICE9IGxkYXRhLT5yZWFkX3RhaWwp
CisJaWYgKHRhaWwgIT0gbGRhdGEtPnJlYWRfdGFpbCkgeworCQkvKgorCQkgKiBNYWtlIHN1cmUg
bm9fcm9vbSBpcyBub3QgcmVhZCBiZWZvcmUgc2V0dGluZyByZWFkX3RhaWwsCisJCSAqIG90aGVy
d2lzZSwgZm9sbG93aW5nIHJhY2UgbWF5IG9jY3VyOgorCQkgKiBuX3R0eV9yZWFkKCkJCSAgICAg
ICAgICAgICAgICB8bl90dHlfcmVjZWl2ZV9idWZfY29tbW9uKCkKKwkJICogaWYobGRhdGEtPm5v
X3Jvb20pLT5mYWxzZSAgICAgICAgICAgIHwKKwkJICoJCQkgICAgICAgICAgICAgICAgfGxkYXRh
LT5ub19yb29tID0gMQorCQkgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fGNoYXJfaW5fYnVmZmVyKCkgPiAwCisJCSAqIGxkYXRhLT5yZWFkX3RhaWwgPSBsZGF0YS0+Y29t
bWl0X2hlYWR8CisJCSAqIFRoZW4gY29weV9mcm9tX3JlYWRfYnVmKCkgaW4gcmVhZGVyIGNvbnN1
bWVzIGFsbCB0aGUgZGF0YQorCQkgKiBpbiByZWFkIGJ1ZmZlciwgYm90aCByZWFkZXIgYW5kIGt3
b3JrZXIgd2lsbCBmYWlsIHRvIGtpY2sKKwkJICogdHR5X2J1ZmZlcl9yZXN0YXJ0X3dvcmsoKS4K
KwkJICogc21wX21iIGlzIHBhaXJlZCB3aXRoIHNtcF9tYigpIGluIG5fdHR5X3JlY2VpdmVfYnVm
X2NvbW1vbigpLgorCQkgKi8KKwkJc21wX21iKCk7CiAJCW5fdHR5X2tpY2tfd29ya2VyKHR0eSk7
CisJfQogCXVwX3JlYWQoJnR0eS0+dGVybWlvc19yd3NlbSk7CiAKIAlyZW1vdmVfd2FpdF9xdWV1
ZSgmdHR5LT5yZWFkX3dhaXQsICZ3YWl0KTsKLS0gCjIuMjcuMAoK
--000000000000692fb405e0c79da4--
