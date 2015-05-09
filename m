From: Mason <slash.tmp@free.fr>
Subject: Hardware spec prevents optimal performance in device driver
Date: Sat, 09 May 2015 12:22:43 +0200
Message-ID: <554DDFF3.5060906@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Mans Rullgard <mans@mansr.com>
List-Id: linux-serial@vger.kernel.org

Hello everyone,

I'm writing a device driver for a serial-ish kind of device.
I'm interested in the TX side of the problem. (I'm working on
an ARM Cortex A9 system by the way.)

There's a 16-byte TX FIFO. Data is queued to the FIFO by writing
{1,2,4} bytes to a TX{8,16,32} memory-mapped register.
Reading the TX_DEPTH register returns the current queue depth.

The TX_READY IRQ is asserted when (and only when) TX_DEPTH
transitions from 1 to 0.

With this spec in mind, I don't see how it is possible to
attain optimal TX performance in the driver. There's a race
between the SW thread filling the queue and the HW thread
emptying it.

My first attempt went along these lines:

SW thread pseudo-code (blocking write)

while (bytes_to_send > 16) {
  write 16 bytes to the queue /* NON ATOMIC */
  bytes_to_send -= 16;
  wait for semaphore
}
write the last bytes to the queue
wait for semaphore

The simplest way to "write 16 bytes to the queue" is
a byte-access loop.

for (i = 0; i < 16; ++i) write buf[i] to TX8
or -- just slightly more complex
for (i = 0; i < 4; ++i) write buf[4i .. 4i+3] to TX32

But you see the problem: I write a byte, and then, for some
reason (low freq from cpufreq, IRQ) the CPU takes a very long
time to get to the next, thus TX_READY fires before I even
write the next byte.

In short, TX_READY could fire at any point while filling the queue.

In my opinion, the semantics of TX_READY are fuzzy. When I hit
the ISR, I just know that "the TX queue reached 0 at some point
in time" but the HW might still be working on sending some bytes.

Seems the best one can do is:

while (bytes_to_send > 4) {
  write 4 bytes to TX32 /* ATOMIC */
  bytes_to_send -= 4;
  wait for semaphore
}
while (bytes_to_send > 0) {
  write 1 byte to TX8 /* ATOMIC */
  bytes_to_send -= 1;
  wait for semaphore
}

(This is ignoring the fact that the original buffer to
send may not be word-aligned, I will have to investigate
misaligned loads, or handle the first 0-3 bytes manually.)

In the solution proposed above, using atomic writes to
the device, I know that TX_READY signals "the work you
requested in now complete". But I have sacrificed
performance, as I will take an IRQ for every 4 bytes,
instead of one for every 16 bytes.

Is this making any sense? Or am I completely mistaken?

Regards.
