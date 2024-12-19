/*
 * Copyright (c) 2023 Arm Limited.
 *
 * SPDX-License-Identifier: MIT
 */

#pragma once

#include "hwcpipe/detail/internal_types.hpp"
#include "hwcpipe/hwcpipe_counter.h"
#include "hwcpipe/types.hpp"

#include <unordered_map>

namespace hwcpipe {
namespace database {

/**
 * A type that maps from counter identifier to the block/offset address for a
 * particular GPU.
 */
using gpu_counters_map = std::unordered_map<hwcpipe_counter, detail::counter_definition>;

extern const std::unordered_map<gpu_id_type, gpu_counters_map> all_gpu_counters;

} // namespace database
} // namespace hwcpipe